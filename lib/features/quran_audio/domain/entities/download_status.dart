/// Entity representing the download status of a Surah
class DownloadStatus {
  final DownloadState state;
  final double progress;
  final String? errorMessage;

  const DownloadStatus({
    this.state = DownloadState.notDownloaded,
    this.progress = 0.0,
    this.errorMessage,
  });

  bool get isDownloading => state == DownloadState.downloading;
  bool get isDownloaded => state == DownloadState.downloaded;
  bool get isNotDownloaded => state == DownloadState.notDownloaded;
  bool get hasFailed => state == DownloadState.failed;

  DownloadStatus copyWith({
    DownloadState? state,
    double? progress,
    String? errorMessage,
  }) {
    return DownloadStatus(
      state: state ?? this.state,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Enum representing different states of download
enum DownloadState {
  notDownloaded,
  downloading,
  downloaded,
  failed,
}