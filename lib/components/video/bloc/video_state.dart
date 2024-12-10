part of 'video_bloc.dart';

class VideoState extends Equatable {
  final VideoDataModel? videoData;
  final VideoPlayerController? controller;
  final bool isInitialized;
  final bool isPlaying;
  final double maxWidth;
  final double maxHeight;

  const VideoState(
    this.videoData,
    this.controller,
    this.isInitialized,
    this.isPlaying,
    this.maxWidth,
    this.maxHeight,
  );

  VideoState copyWith({
    VideoDataModel? videoData,
    VideoPlayerController? controller,
    bool? isInitialized,
    bool? isPlaying,
    double? maxWidth,
    double? maxHeight,
  }) {
    return VideoState(
      videoData ?? this.videoData,
      controller ?? this.controller,
      isInitialized ?? this.isInitialized,
      isPlaying ?? this.isPlaying,
      maxWidth ?? this.maxWidth,
      maxHeight ?? this.maxHeight,
    );
  }

  @override
  List<Object> get props => [
        isInitialized,
        isPlaying,
        maxHeight,
        maxWidth,
      ];
}

final class PlayerInitial extends VideoState {
  const PlayerInitial(
    super.videoData,
    super.controller,
    super.isInitialized,
    super.isPlaying,
    super.maxWidth,
    super.maxHeight,
  );
}

final class PlayerReset extends PlayerInitial {
  const PlayerReset() : super(null, null, false, false, 0, 0);
}
