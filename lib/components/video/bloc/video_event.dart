part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class InitializeVideo extends VideoEvent {
  final XFile file;

  const InitializeVideo(this.file);

  @override
  List<Object> get props => [file];
}

// class PlayVideo extends VideoEvent {}

// class PauseVideo extends VideoEvent {}

// class DisposeVideo extends VideoEvent {}

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
