import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/quran.dart' as quran;

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
  final Map<int, double> downloadProgress; // surahNumber -> progress (0.0 to 1.0)
  final Set<int> downloadedSurahs;

  AudioState({
    this.isPlaying = false,
    this.isLoading = false,
    this.currentAudioUrl,
    this.playingVerseId,
    this.currentSurahNumber,
    this.loopMode = LoopMode.off,
    this.keepPlayingInBackground = true,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.downloadProgress = const {},
    this.downloadedSurahs = const {},
  });

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
    Map<int, double>? downloadProgress,
    Set<int>? downloadedSurahs,
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
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadedSurahs: downloadedSurahs ?? this.downloadedSurahs,
    );
  }
}

class QuranAudioPlayerController extends StateNotifier<AudioState> with WidgetsBindingObserver {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Dio _dio = Dio();
  Timer? _sleepTimer;

  QuranAudioPlayerController() : super(AudioState()) {
    _initListeners();
    _checkDownloadedSurahs();
    WidgetsBinding.instance.addObserver(this);
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
    final dir = await getApplicationDocumentsDirectory();
    final Set<int> downloaded = {};
    for (int i = 1; i <= 114; i++) {
      final file = File('${dir.path}/surahs/surah_$i.mp3');
      if (await file.exists()) {
        downloaded.add(i);
      }
    }
    state = state.copyWith(downloadedSurahs: downloaded);
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
            playSurah(1); // Restart from first surah
          }
        } else if (state.loopMode == LoopMode.off) {
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

    _audioPlayer.loopModeStream.listen((loopMode) {
      state = state.copyWith(loopMode: loopMode);
    });
  }

  Future<AudioSource> _getAudioSource(String url, int? surahNumber, {int? verseId}) async {
    String title = "Quran Recitation";
    String artist = "Reciter";

    if (surahNumber != null) {
      title = quran.getSurahNameEnglish(surahNumber);
      artist = "Surah ${quran.getSurahNameArabic(surahNumber)}";
    } else if (verseId != null) {
      // Logic to extract surah and verse from ID if possible
      // Assuming ID is surah*1000 + verse or similar
      int sNum = verseId ~/ 1000;
      int vNum = verseId % 1000;
      if (sNum > 0 && sNum <= 114) {
        title = "${quran.getSurahNameEnglish(sNum)} - Verse $vNum";
        artist = quran.getSurahNameArabic(sNum);
      } else {
        title = "Verse $verseId";
      }
    }
    
    final MediaItem tag = MediaItem(
      id: url,
      album: "Al-Quran",
      title: title,
      artist: artist,
      artUri: Uri.parse("https://auraq.app/assets/app_logos/auraq_logo.png"),
    );

    if (surahNumber != null) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/surahs/surah_$surahNumber.mp3');
      if (await file.exists()) {
        return AudioSource.uri(Uri.file(file.path), tag: tag);
      }
    }

    // Use LockCachingAudioSource for online URLs to provide basic caching
    return LockCachingAudioSource(Uri.parse(url), tag: tag);
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
        );
        final source = await _getAudioSource(url, null, verseId: verseId);
        await _audioPlayer.setAudioSource(source);
        await _audioPlayer.play();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> playSurah(int surahNumber) async {
    final url = quran.getAudioURLBySurah(surahNumber);
    try {
      if (state.currentAudioUrl == url && state.currentSurahNumber == surahNumber) {
        if (!state.isPlaying) {
          await _audioPlayer.play();
        }
      } else {
        state = state.copyWith(
          isLoading: true,
          currentAudioUrl: url,
          currentSurahNumber: surahNumber,
          playingVerseId: surahNumber * 1000,
        );
        final source = await _getAudioSource(url, surahNumber);
        await _audioPlayer.setAudioSource(source);
        await _audioPlayer.play();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> downloadSurah(int surahNumber) async {
    if (state.downloadedSurahs.contains(surahNumber)) return;
    
    final url = quran.getAudioURLBySurah(surahNumber);
    final dir = await getApplicationDocumentsDirectory();
    final surahsDir = Directory('${dir.path}/surahs');
    if (!await surahsDir.exists()) {
      await surahsDir.create(recursive: true);
    }
    
    final savePath = '${surahsDir.path}/surah_$surahNumber.mp3';
    
    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            final Map<int, double> updatedProgress = Map.from(state.downloadProgress);
            updatedProgress[surahNumber] = progress;
            state = state.copyWith(downloadProgress: updatedProgress);
          }
        },
      );
      
      final updatedDownloaded = Set<int>.from(state.downloadedSurahs);
      updatedDownloaded.add(surahNumber);
      
      final Map<int, double> updatedProgress = Map.from(state.downloadProgress);
      updatedProgress.remove(surahNumber);
      
      state = state.copyWith(
        downloadedSurahs: updatedDownloaded,
        downloadProgress: updatedProgress,
      );
    } catch (e) {
      final Map<int, double> updatedProgress = Map.from(state.downloadProgress);
      updatedProgress.remove(surahNumber);
      state = state.copyWith(downloadProgress: updatedProgress);
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
    }
    await _audioPlayer.setLoopMode(nextMode);
  }

  void toggleBackgroundPlay() {
    state = state.copyWith(keepPlayingInBackground: !state.keepPlayingInBackground);
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
    if (minutes > 0) {
      _sleepTimer = Timer(Duration(minutes: minutes), () {
        stopAudio();
      });
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    state = state.copyWith(
      isPlaying: false,
      isLoading: false,
      currentAudioUrl: null,
      playingVerseId: null,
      currentSurahNumber: null,
      position: Duration.zero,
      duration: Duration.zero,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }
}

final quranAudioPlayerControllerProvider =
    StateNotifierProvider<QuranAudioPlayerController, AudioState>((ref) {
      return QuranAudioPlayerController();
    });
