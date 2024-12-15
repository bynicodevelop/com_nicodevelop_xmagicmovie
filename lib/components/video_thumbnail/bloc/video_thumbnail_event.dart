part of 'video_thumbnail_bloc.dart';

sealed class VideoThumbnailEvent extends Equatable {
  final ConfigModel config;

  const VideoThumbnailEvent({
    required this.config,
  });

  @override
  List<Object> get props => [
        config,
      ];
}

class OnLoadVideoThumbnail extends VideoThumbnailEvent {
  const OnLoadVideoThumbnail({
    required super.config,
  });
}