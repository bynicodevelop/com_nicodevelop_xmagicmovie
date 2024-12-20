part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class InitializeVideo extends VideoEvent {
  final VideoDataModel videoDataModel;

  const InitializeVideo(
    this.videoDataModel,
  );

  @override
  List<Object> get props => [
        videoDataModel,
      ];
}

class OnResetVideoEvent extends VideoEvent {
  const OnResetVideoEvent();
}

class UpdateConstraintsEvent extends VideoEvent {
  final double maxWidth;
  final double maxHeight;

  const UpdateConstraintsEvent(
    this.maxWidth,
    this.maxHeight,
  );

  @override
  List<Object> get props => [maxWidth, maxHeight];
}

class OnPlayEvent extends VideoEvent {
  const OnPlayEvent();
}

class OnPauseEvent extends VideoEvent {
  const OnPauseEvent();
}
