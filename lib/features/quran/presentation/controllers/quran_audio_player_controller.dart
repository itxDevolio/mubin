import 'dart:async';
import 'dart:io';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:auraq/features/quran/domain/entities/reciter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/quran.dart' as quran;

/// Download status for a surah
enum DownloadStatus { notDownloaded, downloading, downloaded, failed }

/// Download info for tracking individual downloads
class DownloadInfo {
  final int surahNumber;
  final DownloadStatus status;
  final double progress;
  final String? errorMessage;

  DownloadInfo({
    required this.surahNumber,
    this.status = DownloadStatus.notDownloaded,
    this.progress = 0.0,
    this.errorMessage,
  });

  DownloadInfo copyWith({
    DownloadStatus? status,
    double? progress,
    String? errorMessage,
  }) {
    return DownloadInfo(
      surahNumber: surahNumber,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AudioState {
  final bool isPlaying;
  final bool isLoading;
  final String? currentAudioUrl;
  final int? playingVerseId;
  final int? currentSurahNumber;
  final LoopMode loopMode;
  final bool keepPlayingInBackground;
  final Duration position;
  final Duration duration;
  final Map<int, DownloadInfo> downloadInfoMap;
  final Set<int> downloadedSurahs;
  final Reciter currentReciter;
  final String? errorMessage;
  final bool isPlayingFromLocal;
  final Duration? remainingSleepTimer;

  AudioState({
    this.isPlaying = false,
    this.isLoading = false,
    this.currentAudioUrl,
    this.playingVerseId,
    this.currentSurahNumber,
    this.loopMode = LoopMode.off,
    this.keepPlayingInBackground = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.downloadInfoMap = const {},
    this.downloadedSurahs = const {},
    required this.currentReciter,
    this.errorMessage,
    this.isPlayingFromLocal = false,
    this.remainingSleepTimer,
  });

  bool isSurahDownloaded(int surahNumber) => downloadedSurahs.contains(surahNumber);
  
  DownloadStatus getDownloadStatus(int surahNumber) => 
      downloadInfoMap[surahNumber]?.status ?? DownloadStatus.notDownloaded;
  
  double getDownloadProgress(int surahNumber) => 
      downloadInfoMap[surahNumber]?.progress ?? 0.0;

  AudioState copyWith({
    bool? isPlaying,
    bool? isLoading,
    String? currentAudioUrl,
    int? playingVerseId,
    int? currentSurahNumber,
    LoopMode? loopMode,
    bool? keepPlayingInBackground,
    Duration? position,
    Duration? duration,
    Map<int, DownloadInfo>? downloadInfoMap,
    Set<int>? downloadedSurahs,
    Reciter? currentReciter,
    String? errorMessage,
    bool? isPlayingFromLocal,
    Duration? remainingSleepTimer,
    bool clearSleepTimer = false,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      currentAudioUrl: currentAudioUrl ?? this.currentAudioUrl,
      playingVerseId: playingVerseId ?? this.playingVerseId,
      currentSurahNumber: currentSurahNumber ?? this.currentSurahNumber,
      loopMode: loopMode ?? this.loopMode,
      keepPlayingInBackground: keepPlayingInBackground ?? this.keepPlayingInBackground,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      downloadInfoMap: downloadInfoMap ?? this.downloadInfoMap,
      downloadedSurahs: downloadedSurahs ?? this.downloadedSurahs,
      currentReciter: currentReciter ?? this.currentReciter,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlayingFromLocal: isPlayingFromLocal ?? this.isPlayingFromLocal,
      remainingSleepTimer: clearSleepTimer ? null : (remainingSleepTimer ?? this.remainingSleepTimer),
    );
  }
}

class QuranAudioPlayerController extends Notifier<AudioState> with WidgetsBindingObserver {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Dio _dio = Dio();
  Timer? _sleepTimer;
  Timer? _countdownTimer;
  CancelToken? _downloadCancelToken;

  @override
  AudioState build() {
    final settings = ref.watch(settingsControllerProvider);
    final initialReciter = settings.currentReciter;
    final initialKeepBg = settings.keepPlayingInBackground;
    
    Future.microtask(() {
      _initListeners();
      _checkDownloadedSurahs();
      _setupAudioPlayer();
      WidgetsBinding.instance.addObserver(this);
    });

    ref.listen(settingsControllerProvider, (previous, next) {
      if (previous?.keepPlayingInBackground != next.keepPlayingInBackground) {
        state = state.copyWith(keepPlayingInBackground: next.keepPlayingInBackground);
      }
    });

    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _audioPlayer.dispose();
      _sleepTimer?.cancel();
      _countdownTimer?.cancel();
    });

    return AudioState(
      currentReciter: initialReciter,
      keepPlayingInBackground: initialKeepBg,
    );
  }

  void _setupAudioPlayer() {
    _audioPlayer.setAutomaticallyWaitsToMinimizeStalling(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (!this.state.keepPlayingInBackground) {
        pauseAudio();
      }
    }
  }

  Future<void> _checkDownloadedSurahs() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final Set<int> downloaded = {};
      final String reciterFolder = state.currentReciter.name.replaceAll(' ', '_');
      final surahsDir = Directory('${dir.path}/surahs/$reciterFolder');
      
      if (await surahsDir.exists()) {
        for (int i = 1; i <= 114; i++) {
          final file = File('${surahsDir.path}/surah_$i.mp3');
          if (await file.exists()) {
            downloaded.add(i);
          }
        }
      }
      
      state = state.copyWith(downloadedSurahs: downloaded);
    } catch (e) {
      debugPrint('Error checking downloads: $e');
    }
  }

  void _initListeners() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      state = state.copyWith(
        isPlaying: playerState.playing,
        isLoading: processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering,
      );
      
      if (processingState == ProcessingState.completed) {
        if (state.loopMode == LoopMode.all) {
          if (state.currentSurahNumber != null && state.currentSurahNumber! < 114) {
            playSurah(state.currentSurahNumber! + 1);
          } else if (state.currentSurahNumber == 114) {
            playSurah(1);
          }
        } else if (state.loopMode == LoopMode.one) {
          _audioPlayer.seek(Duration.zero);
          _audioPlayer.play();
        } else {
          stopAudio();
        }
      }
    });

    _audioPlayer.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
    });

    _audioPlayer.durationStream.listen((dur) {
      if (dur != null) {
        state = state.copyWith(duration: dur);
      }
    });

    _audioPlayer.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      debugPrint('Audio error: $e');
      state = state.copyWith(isLoading: false, isPlaying: false);
    });
  }

  Future<AudioSource> _getAudioSource(String url, int? surahNumber, {int? verseId}) async {
    String title = "Quran Recitation";
    String artist = state.currentReciter.name;

    if (surahNumber != null) {
      title = quran.getSurahNameEnglish(surahNumber);
    } else if (verseId != null) {
      int sNum = verseId ~/ 1000;
      int vNum = verseId % 1000;
      if (sNum > 0 && sNum <= 114) {
        title = "${quran.getSurahNameEnglish(sNum)} - Verse $vNum";
        artist = state.currentReciter.name;
      }
    }
    
    final MediaItem tag = MediaItem(
      id: url,
      album: "Al-Quran",
      title: title,
      artist: artist,
      artUri: Uri.parse("https://quran.com/images/quran-share.png"),
    );

    if (surahNumber != null) {
      final localFile = await _getLocalSurahFile(surahNumber);
      if (await localFile.exists()) {
        state = state.copyWith(isPlayingFromLocal: true);
        return AudioSource.uri(Uri.file(localFile.path), tag: tag);
      }
    }

    state = state.copyWith(isPlayingFromLocal: false);
    return LockCachingAudioSource(Uri.parse(url), tag: tag);
  }

  Future<File> _getLocalSurahFile(int surahNumber) async {
    final dir = await getApplicationDocumentsDirectory();
    final String reciterFolder = state.currentReciter.name.replaceAll(' ', '_');
    return File('${dir.path}/surahs/$reciterFolder/surah_$surahNumber.mp3');
  }

  String _getSurahUrl(int surahNumber, Reciter reciter) {
    if (reciter.name == "Mishary Rashid Alafasy") {
      return quran.getAudioURLBySurah(surahNumber);
    }
    final numStr = surahNumber.toString().padLeft(3, '0');
    return "${reciter.urlPrefix}$numStr.mp3";
  }

  Future<void> playVerseAudio(String url, int verseId) async {
    try {
      if (state.currentAudioUrl == url) {
        if (!state.isPlaying) {
          await _audioPlayer.play();
        }
      } else {
        state = state.copyWith(
          isLoading: true,
          currentAudioUrl: url,
          playingVerseId: verseId,
          currentSurahNumber: null,
          errorMessage: null,
          isPlayingFromLocal: false,
        );
        final source = await _getAudioSource(url, null, verseId: verseId);
        await _audioPlayer.setAudioSource(source);
        await _audioPlayer.play();
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Could not load audio. Check your internet.",
      );
    }
  }

  Future<void> playSurah(int surahNumber) async {
    final url = _getSurahUrl(surahNumber, state.currentReciter);
    try {
      if (state.currentAudioUrl == url && state.currentSurahNumber == surahNumber) {
        if (!state.isPlaying) {
          await _audioPlayer.play();
        }
        return;
      }

      state = state.copyWith(
        isLoading: true,
        currentAudioUrl: url,
        currentSurahNumber: surahNumber,
        playingVerseId: surahNumber * 1000,
        errorMessage: null,
      );

      final source = await _getAudioSource(url, surahNumber);
      await _audioPlayer.setAudioSource(source);
      await _audioPlayer.play();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Could not load audio. Check your internet.",
      );
    }
  }

  Future<void> downloadSurah(int surahNumber) async {
    if (state.downloadedSurahs.contains(surahNumber)) return;
    if (state.downloadInfoMap[surahNumber]?.status == DownloadStatus.downloading) return;

    final url = _getSurahUrl(surahNumber, state.currentReciter);
    final dir = await getApplicationDocumentsDirectory();
    final String reciterFolder = state.currentReciter.name.replaceAll(' ', '_');
    final surahsDir = Directory('${dir.path}/surahs/$reciterFolder');
    
    if (!await surahsDir.exists()) {
      await surahsDir.create(recursive: true);
    }
    
    final savePath = '${surahsDir.path}/surah_$surahNumber.mp3';
    _downloadCancelToken = CancelToken();
    
    final updatedMap = Map<int, DownloadInfo>.from(state.downloadInfoMap);
    updatedMap[surahNumber] = DownloadInfo(surahNumber: surahNumber, status: DownloadStatus.downloading);
    state = state.copyWith(downloadInfoMap: updatedMap);
    
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: _downloadCancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            final updated = Map<int, DownloadInfo>.from(state.downloadInfoMap);
            updated[surahNumber] = DownloadInfo(
              surahNumber: surahNumber,
              status: DownloadStatus.downloading,
              progress: progress,
            );
            state = state.copyWith(downloadInfoMap: updated);
          }
        },
      );
      
      final updatedDownloaded = Set<int>.from(state.downloadedSurahs);
      updatedDownloaded.add(surahNumber);
      
      final finalMap = Map<int, DownloadInfo>.from(state.downloadInfoMap);
      finalMap[surahNumber] = DownloadInfo(
        surahNumber: surahNumber,
        status: DownloadStatus.downloaded,
        progress: 1.0,
      );
      
      state = state.copyWith(
        downloadedSurahs: updatedDownloaded,
        downloadInfoMap: finalMap,
      );
    } catch (e) {
      if (CancelToken.isCancel(e as DioException)) {
        debugPrint('Download cancelled');
      } else {
        final errorMap = Map<int, DownloadInfo>.from(state.downloadInfoMap);
        errorMap[surahNumber] = DownloadInfo(
          surahNumber: surahNumber,
          status: DownloadStatus.failed,
          errorMessage: e.toString(),
        );
        state = state.copyWith(downloadInfoMap: errorMap);
      }
    } finally {
      _downloadCancelToken = null;
    }
  }

  Future<void> cancelDownload(int surahNumber) async {
    _downloadCancelToken?.cancel();
    final updatedMap = Map<int, DownloadInfo>.from(state.downloadInfoMap);
    updatedMap[surahNumber] = DownloadInfo(
      surahNumber: surahNumber,
      status: DownloadStatus.notDownloaded,
    );
    state = state.copyWith(downloadInfoMap: updatedMap);
  }

  Future<void> deleteDownloadedSurah(int surahNumber) async {
    try {
      final file = await _getLocalSurahFile(surahNumber);
      if (await file.exists()) {
        await file.delete();
      }
      
      final updatedDownloaded = Set<int>.from(state.downloadedSurahs);
      updatedDownloaded.remove(surahNumber);
      
      final updatedMap = Map<int, DownloadInfo>.from(state.downloadInfoMap);
      updatedMap.remove(surahNumber);
      
      state = state.copyWith(
        downloadedSurahs: updatedDownloaded,
        downloadInfoMap: updatedMap,
      );
    } catch (e) {
      debugPrint('Error deleting surah: $e');
    }
  }

  Future<void> deleteAllDownloads() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final String reciterFolder = state.currentReciter.name.replaceAll(' ', '_');
      final surahsDir = Directory('${dir.path}/surahs/$reciterFolder');
      
      if (await surahsDir.exists()) {
        await surahsDir.delete(recursive: true);
      }
      
      state = state.copyWith(
        downloadedSurahs: {},
        downloadInfoMap: {},
      );
    } catch (e) {
      debugPrint('Error deleting all: $e');
    }
  }

  Future<int> getDownloadStorageSize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final String reciterFolder = state.currentReciter.name.replaceAll(' ', '_');
      final surahsDir = Directory('${dir.path}/surahs/$reciterFolder');
      
      if (!await surahsDir.exists()) return 0;
      
      int totalSize = 0;
      await for (final entity in surahsDir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  List<int> getDownloadedSurahsList() {
    return state.downloadedSurahs.toList()..sort();
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Future<void> setReciter(Reciter reciter) async {
    if (state.currentReciter == reciter) return;
    
    if (ref.read(settingsControllerProvider).currentReciter != reciter) {
      ref.read(settingsControllerProvider.notifier).setReciter(reciter);
    }

    final int? currentSurah = state.currentSurahNumber;
    final bool wasPlaying = state.isPlaying;
    
    state = state.copyWith(currentReciter: reciter);
    await _checkDownloadedSurahs();
    
    if (currentSurah != null) {
      await playSurah(currentSurah);
      if (!wasPlaying) {
        await pauseAudio();
      }
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> toggleLoop() async {
    LoopMode nextMode;
    switch (state.loopMode) {
      case LoopMode.off:
        nextMode = LoopMode.all;
        break;
      case LoopMode.all:
        nextMode = LoopMode.one;
        break;
      case LoopMode.one:
        nextMode = LoopMode.off;
        break;
      default:
        nextMode = LoopMode.off;
    }
    await _audioPlayer.setLoopMode(nextMode);
    state = state.copyWith(loopMode: nextMode);
  }

  void toggleBackgroundPlay() {
    final newValue = !state.keepPlayingInBackground;
    state = state.copyWith(keepPlayingInBackground: newValue);
    ref.read(settingsControllerProvider.notifier).setKeepPlayingInBackground(newValue);
  }

  Future<void> skipNext() async {
    if (state.currentSurahNumber != null && state.currentSurahNumber! < 114) {
      await playSurah(state.currentSurahNumber! + 1);
    }
  }

  Future<void> skipPrevious() async {
    if (state.currentSurahNumber != null && state.currentSurahNumber! > 1) {
      await playSurah(state.currentSurahNumber! - 1);
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.play();
  }

  void setSleepTimer(int minutes) {
    _sleepTimer?.cancel();
    _countdownTimer?.cancel();
    
    if (minutes > 0) {
      Duration remaining = Duration(minutes: minutes);
      state = state.copyWith(remainingSleepTimer: remaining);
      
      _sleepTimer = Timer(remaining, () {
        stopAudio();
      });
      
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.remainingSleepTimer != null) {
          final newRemaining = state.remainingSleepTimer! - const Duration(seconds: 1);
          if (newRemaining.isNegative) {
            timer.cancel();
            state = state.copyWith(clearSleepTimer: true);
          } else {
            state = state.copyWith(remainingSleepTimer: newRemaining);
          }
        } else {
          timer.cancel();
        }
      });
    } else {
      state = state.copyWith(clearSleepTimer: true);
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _sleepTimer?.cancel();
    _countdownTimer?.cancel();
    state = state.copyWith(
      isPlaying: false,
      isLoading: false,
      currentAudioUrl: null,
      playingVerseId: null,
      currentSurahNumber: null,
      position: Duration.zero,
      duration: Duration.zero,
      clearSleepTimer: true,
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final quranAudioPlayerControllerProvider =
    NotifierProvider<QuranAudioPlayerController, AudioState>(() {
  return QuranAudioPlayerController();
});