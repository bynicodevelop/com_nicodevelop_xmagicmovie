part of 'video_bloc.dart';

class VideoState extends Equatable {
  final VideoPlayerController? controller;
  final bool isInitialized;
  final bool isPlaying;
  final double maxWidth;
  final double maxHeight;

  const VideoState(
    this.controller,
    this.isInitialized,
    this.isPlaying,
    this.maxWidth,
    this.maxHeight,
  );

  VideoState copyWith({
    VideoPlayerController? controller,
    bool? isInitialized,
    bool? isPlaying,
    double? maxWidth,
    double? maxHeight,
  }) {
    return VideoState(
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
  const PlayerInitial() : super(null, false, false, 0, 0);
}
