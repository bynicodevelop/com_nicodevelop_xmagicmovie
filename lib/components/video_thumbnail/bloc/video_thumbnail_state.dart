part of 'video_thumbnail_bloc.dart';

sealed class VideoThumbnailState extends Equatable {
  const VideoThumbnailState();

  @override
  List<Object> get props => [];
}

final class VideoThumbnailInitial extends VideoThumbnailState {}

final class VideoThumbnailLoading extends VideoThumbnailState {}

final class VideoThumbnailLoaded extends VideoThumbnailState {
  final String id;
  final Uint8List thumbnail;

  const VideoThumbnailLoaded({
    required this.id,
    required this.thumbnail,
  });

  @override
  List<Object> get props => [
        id,
        thumbnail,
      ];
}
