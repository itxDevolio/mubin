import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;

import '../../domain/entities/reciter.dart';
import '../../domain/entities/download_status.dart';
import '../../domain/entities/audio_playback_state.dart';
import '../../domain/repositories/quran_audio_repository.dart';
import '../../data/datasources/quran_audio_local_datasource.dart';
import '../../data/datasources/quran_audio_remote_datasource.dart';
import '../../data/repositories/quran_audio_repository_impl.dart';

/// State for the Quran Audio Player
class QuranAudioState {
  final AudioPlaybackState playbackState;
  final AudioLoopMode loopMode;
  final Reciter currentReciter;
  final int? currentSurahNumber;
  final int? currentVerseNumber;
  final Duration position;
  final Duration duration;
  final bool isLoading;
  final String? errorMessage;
  final Map<int, DownloadStatus> downloadStatusMap;
  final Set<int> downloadedSurahs;
  final bool keepPlayingInBackground;
  final bool isPlayingFromLocal;
  final int? sleepTimerMinutes;

  QuranAudioState({
    this.playbackState = AudioPlaybackState.idle,
    this.loopMode = AudioLoopMode.off,
    required this.currentReciter,
    this.currentSurahNumber,
    this.currentVerseNumber,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isLoading = false,
    this.errorMessage,
    this.downloadStatusMap = const {},
    this.downloadedSurahs = const {},
    this.keepPlayingInBackground = true,
    this.isPlayingFromLocal = false,
    this.sleepTimerMinutes,
  });

  bool get isPlaying => playbackState == AudioPlaybackState.playing;
  bool get isPaused => playbackState == AudioPlaybackState.paused;
  bool get isIdle => playbackState == AudioPlaybackState.idle;

  bool isSurahDownloaded(int surahNumber) => downloadedSurahs.contains(surahNumber);

  DownloadStatus? getDownloadStatus(int surahNumber) => downloadStatusMap[surahNumber];

  QuranAudioState copyWith({
    AudioPlaybackState? playbackState,
    AudioLoopMode? loopMode,
    Reciter? currentReciter,
    int? currentSurahNumber,
    int? currentVerseNumber,
    Duration? position,
    Duration? duration,
    bool? isLoading,
    String? errorMessage,
    Map<int, DownloadStatus>? downloadStatusMap,
    Set<int>? downloadedSurahs,
    bool? keepPlayingInBackground,
    bool? isPlayingFromLocal,
    int? sleepTimerMinutes,
  }) {
    return QuranAudioState(
      playbackState: playbackState ?? this.playbackState,
      loopMode: loopMode ?? this.loopMode,
      currentReciter: currentReciter ?? this.currentReciter,
      currentSurahNumber: currentSurahNumber ?? this.currentSurahNumber,
      currentVerseNumber: currentVerseNumber ?? this.currentVerseNumber,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadStatusMap: downloadStatusMap ?? this.downloadStatusMap,
      downloadedSurahs: downloadedSurahs ?? this.downloadedSurahs,
      keepPlayingInBackground: keepPlayingInBackground ?? this.keepPlayingInBackground,
      isPlayingFromLocal: isPlayingFromLocal ?? this.isPlayingFromLocal,
      sleepTimerMinutes: sleepTimerMinutes ?? this.sleepTimerMinutes,
    );
  }
}

/// Notifier for Quran Audio Player
class QuranAudioController extends Notifier<QuranAudioState> {
  late final QuranAudioRepository _repository;
  late final AudioPlayer _audioPlayer;
  Timer? _sleepTimer;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerCompleteSubscription;

  @override
  QuranAudioState build() {
    _setupRepository();
    _setupAudioPlayer();
    _setupListeners();
    _loadDownloadedSurahs();
    return QuranAudioState(currentReciter: Reciters.defaultReciter);
  }

  void _setupRepository() {
    final localDataSource = QuranAudioLocalDataSourceImpl();
    final remoteDataSource = QuranAudioRemoteDataSourceImpl();
    _repository = QuranAudioRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
  }

  void _setupAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAutomaticallyWaitsToMinimizeStalling(true);
  }

  void _setupListeners() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      AudioPlaybackState playbackState;
      
      switch (playerState.processingState) {
        case ProcessingState.idle:
          playbackState = AudioPlaybackState.idle;
          break;
        case ProcessingState.loading:
        case ProcessingState.buffering:
          playbackState = AudioPlaybackState.buffering;
          break;
        case ProcessingState.ready:
          playbackState = playerState.playing 
              ? AudioPlaybackState.playing 
              : AudioPlaybackState.paused;
          break;
        case ProcessingState.completed:
          playbackState = AudioPlaybackState.completed;
          _onPlaybackComplete();
          break;
      }

      state = state.copyWith(
        playbackState: playbackState,
        isLoading: playbackState == AudioPlaybackState.buffering,
      );
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });

    // Handle errors through playbackEventStream
    _audioPlayer.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      debugPrint('Audio player error: $e');
      state = state.copyWith(
        playbackState: AudioPlaybackState.error,
        errorMessage: e.toString(),
      );
    });
  }

  void _onPlaybackComplete() {
    switch (state.loopMode) {
      case AudioLoopMode.all:
        _playNextSurah();
        break;
      case AudioLoopMode.one:
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play();
        break;
      case AudioLoopMode.off:
        // Stop playback
        _audioPlayer.stop();
        state = state.copyWith(
          playbackState: AudioPlaybackState.completed,
        );
        break;
    }
  }

  void _playNextSurah() {
    if (state.currentSurahNumber == null) return;

    final nextSurah = state.currentSurahNumber! + 1;
    if (nextSurah <= 114) {
      playSurah(nextSurah);
    } else if (state.loopMode == AudioLoopMode.all) {
      playSurah(1);
    }
  }

  void _playPreviousSurah() {
    if (state.currentSurahNumber == null) return;

    final prevSurah = state.currentSurahNumber! - 1;
    if (prevSurah >= 1) {
      playSurah(prevSurah);
    } else if (state.loopMode == AudioLoopMode.all) {
      playSurah(114);
    }
  }

  Future<void> _loadDownloadedSurahs() async {
    try {
      final downloaded = await _repository.getDownloadedSurahs(state.currentReciter);
      state = state.copyWith(downloadedSurahs: downloaded.toSet());
    } catch (e) {
      debugPrint('Error loading downloaded surahs: $e');
    }
  }

  // ==================== Playback Methods ====================

  Future<void> playSurah(int surahNumber) async {
    try {
      final reciter = state.currentReciter;
      String audioUrl;
      bool isLocal = false;

      // Check if surah is downloaded
      if (state.isSurahDownloaded(surahNumber)) {
        final localPath = await _repository.getLocalSurahPath(surahNumber, reciter);
        if (localPath != null) {
          audioUrl = localPath;
          isLocal = true;
        } else {
          audioUrl = _repository.getSurahAudioUrl(surahNumber, reciter);
        }
      } else {
        audioUrl = _repository.getSurahAudioUrl(surahNumber, reciter);
      }

      state = state.copyWith(
        playbackState: AudioPlaybackState.loading,
        currentSurahNumber: surahNumber,
        currentVerseNumber: null,
        isLoading: true,
        isPlayingFromLocal: isLocal,
        errorMessage: null,
      );

      // Set up media item for lock screen
      final mediaItem = MediaItem(
        id: 'surah_$surahNumber',
        title: quran.getSurahNameEnglish(surahNumber),
        album: 'Al-Quran Al-Kareem',
        artist: reciter.name,
        artUri: Uri.parse('https://quran.com/images/quran-share.png'),
      );

      final source = AudioSource.uri(
        Uri.parse(audioUrl),
        tag: mediaItem,
      );

      await _audioPlayer.setAudioSource(source);
      await _audioPlayer.play();

      state = state.copyWith(
        playbackState: AudioPlaybackState.playing,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        playbackState: AudioPlaybackState.error,
        isLoading: false,
        errorMessage: 'Error playing Surah: ${e.toString()}',
      );
    }
  }

  Future<void> playVerse(int surahNumber, int verseNumber) async {
    try {
      final reciter = state.currentReciter;
      final audioUrl = _repository.getVerseAudioUrl(surahNumber, verseNumber, reciter);

      state = state.copyWith(
        playbackState: AudioPlaybackState.loading,
        currentSurahNumber: surahNumber,
        currentVerseNumber: verseNumber,
        isLoading: true,
        errorMessage: null,
      );

      final mediaItem = MediaItem(
        id: 'verse_${surahNumber}_$verseNumber',
        title: '${quran.getSurahNameEnglish(surahNumber)} - Verse $verseNumber',
        album: 'Al-Quran Al-Kareem',
        artist: reciter.name,
      );

      final source = AudioSource.uri(
        Uri.parse(audioUrl),
        tag: mediaItem,
      );

      await _audioPlayer.setAudioSource(source);
      await _audioPlayer.play();

      state = state.copyWith(
        playbackState: AudioPlaybackState.playing,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        playbackState: AudioPlaybackState.error,
        isLoading: false,
        errorMessage: 'Error playing verse: ${e.toString()}',
      );
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> stop() async {
    _audioPlayer.stop();
    _sleepTimer?.cancel();
    
    state = state.copyWith(
      playbackState: AudioPlaybackState.idle,
      currentSurahNumber: null,
      currentVerseNumber: null,
      position: Duration.zero,
      duration: Duration.zero,
      isLoading: false,
    );
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> skipNext() async {
    _playNextSurah();
  }

  Future<void> skipPrevious() async {
    _playPreviousSurah();
  }

  // ==================== Reciter Methods ====================

  Future<void> setReciter(Reciter reciter) async {
    if (state.currentReciter == reciter) return;

    await _repository.setCurrentReciter(reciter);
    
    // Reload downloaded surahs for new reciter
    await _loadDownloadedSurahs();

    // If currently playing, switch to new reciter
    if (state.currentSurahNumber != null) {
      await playSurah(state.currentSurahNumber!);
    }

    state = state.copyWith(currentReciter: reciter);
  }

  // ==================== Download Methods ====================

  Future<void> downloadSurah(int surahNumber) async {
    if (state.isSurahDownloaded(surahNumber)) {
      return; // Already downloaded
    }

    try {
      final reciter = state.currentReciter;
      
      // Update download status
      final updatedMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
      updatedMap[surahNumber] = const DownloadStatus(
        state: DownloadState.downloading,
        progress: 0.0,
      );

      state = state.copyWith(downloadStatusMap: updatedMap);

      await _repository.downloadSurah(
        surahNumber,
        reciter,
        onProgress: (progress) {
          final newMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
          newMap[surahNumber] = DownloadStatus(
            state: DownloadState.downloading,
            progress: progress,
          );
          state = state.copyWith(downloadStatusMap: newMap);
        },
      );

      // Update final status
      final downloaded = Set<int>.from(state.downloadedSurahs);
      downloaded.add(surahNumber);

      final finalMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
      finalMap[surahNumber] = const DownloadStatus(
        state: DownloadState.downloaded,
        progress: 1.0,
      );

      state = state.copyWith(
        downloadStatusMap: finalMap,
        downloadedSurahs: downloaded,
      );
    } catch (e) {
      debugPrint('Download error: $e');
      final errorMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
      errorMap[surahNumber] = DownloadStatus(
        state: DownloadState.failed,
        errorMessage: e.toString(),
      );
      state = state.copyWith(downloadStatusMap: errorMap);
    }
  }

  Future<void> cancelDownload(int surahNumber) async {
    await _repository.cancelDownload(surahNumber);
    
    final updatedMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
    updatedMap[surahNumber] = const DownloadStatus(
      state: DownloadState.notDownloaded,
      progress: 0.0,
    );
    state = state.copyWith(downloadStatusMap: updatedMap);
  }

  Future<void> deleteDownloadedSurah(int surahNumber) async {
    await _repository.deleteDownloadedSurah(surahNumber, state.currentReciter);

    final updatedDownloaded = Set<int>.from(state.downloadedSurahs);
    updatedDownloaded.remove(surahNumber);

    final updatedMap = Map<int, DownloadStatus>.from(state.downloadStatusMap);
    updatedMap[surahNumber] = const DownloadStatus(
      state: DownloadState.notDownloaded,
      progress: 0.0,
    );

    state = state.copyWith(
      downloadStatusMap: updatedMap,
      downloadedSurahs: updatedDownloaded,
    );
  }

  Future<void> deleteAllDownloads() async {
    await _repository.deleteAllDownloads(state.currentReciter);

    state = state.copyWith(
      downloadStatusMap: {},
      downloadedSurahs: {},
    );
  }

  // ==================== Loop Mode Methods ====================

  Future<void> toggleLoopMode() async {
    AudioLoopMode newMode;
    switch (state.loopMode) {
      case AudioLoopMode.off:
        newMode = AudioLoopMode.all;
        break;
      case AudioLoopMode.all:
        newMode = AudioLoopMode.one;
        break;
      case AudioLoopMode.one:
        newMode = AudioLoopMode.off;
        break;
    }

    await _audioPlayer.setLoopMode(newMode == AudioLoopMode.off ? LoopMode.off : LoopMode.one);
    state = state.copyWith(loopMode: newMode);
  }

  // ==================== Background Play Methods ====================

  void toggleBackgroundPlay() {
    final newValue = !state.keepPlayingInBackground;
    state = state.copyWith(keepPlayingInBackground: newValue);
  }

  // ==================== Sleep Timer Methods ====================

  void setSleepTimer(int minutes) {
    _sleepTimer?.cancel();

    if (minutes > 0) {
      _sleepTimer = Timer(Duration(minutes: minutes), () {
        stop();
      });
      state = state.copyWith(sleepTimerMinutes: minutes);
    } else {
      state = state.copyWith(sleepTimerMinutes: null);
    }
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    state = state.copyWith(sleepTimerMinutes: null);
  }

  // ==================== Utility Methods ====================

  String getSurahName(int surahNumber) {
    return quran.getSurahNameEnglish(surahNumber);
  }

  String getSurahNameArabic(int surahNumber) {
    return quran.getSurahNameArabic(surahNumber);
  }

  int getVerseCount(int surahNumber) {
    return quran.getVerseCount(surahNumber);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  void dispose() {
    _sleepTimer?.cancel();
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _audioPlayer.dispose();
  }
}

/// Provider for Quran Audio Controller
final quranAudioControllerProvider =
    NotifierProvider<QuranAudioController, QuranAudioState>(() {
  return QuranAudioController();
});
