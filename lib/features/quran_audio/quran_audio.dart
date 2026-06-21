/// Quran Audio Feature Module
/// 
/// This module provides a complete audio player implementation for Quran recitation
/// with only 3 selected reciters, following clean architecture principles.
/// 
/// All audio data is sourced from the quran package.
/// 
/// ## Features:
/// - Play/Pause/Seek audio
/// - Download Surahs for offline playback
/// - Switch between 3 reciters
/// - Loop modes (off, all, one)
/// - Sleep timer
/// - Background playback
/// - Lock screen controls
/// 
/// ## Usage:
/// ```dart
/// import 'package:auraq/features/quran_audio/quran_audio.dart';
/// 
/// // Navigate to audio home screen
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const QuranAudioHomeScreen(),
///   ),
/// );
/// 
/// // Watch audio state
/// ref.watch(quranAudioControllerProvider);
/// ```

// Domain Entities
export 'domain/entities/reciter.dart';
export 'domain/entities/audio_playback_state.dart';
export 'domain/entities/download_status.dart';

// Domain Repository
export 'domain/repositories/quran_audio_repository.dart';

// Domain Use Cases
export 'domain/usecases/get_surah_audio_url_usecase.dart';
export 'domain/usecases/download_surah_usecase.dart';
export 'domain/usecases/get_reciters_usecase.dart';

// Data Layer
export 'data/datasources/quran_audio_local_datasource.dart';
export 'data/datasources/quran_audio_remote_datasource.dart';
export 'data/repositories/quran_audio_repository_impl.dart';

// Presentation Layer
export 'presentation/controllers/quran_audio_controller.dart';
export 'presentation/views/quran_audio_home_screen.dart';
export 'presentation/views/quran_audio_player_screen.dart';
export 'presentation/widgets/mini_audio_player.dart';
