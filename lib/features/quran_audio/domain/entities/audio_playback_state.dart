/// Represents the playback state of the audio player
enum AudioPlaybackState {
  idle,
  playing,
  paused,
  loading,
  buffering,
  completed,
  error,
}

/// Represents the loop mode for the audio player
enum AudioLoopMode {
  off,
  all,
  one,
}