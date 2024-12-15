import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:equatable/equatable.dart';

part 'video_thumbnail_event.dart';
part 'video_thumbnail_state.dart';

class VideoThumbnailBloc
    extends Bloc<VideoThumbnailEvent, VideoThumbnailState> {
  final VideoManager videoManager;

  VideoThumbnailBloc({
    required this.videoManager,
  }) : super(VideoThumbnailInitial()) {
    on<OnLoadVideoThumbnail>((event, emit) async {
      emit(VideoThumbnailLoading());

      final Uint8List? thumbnail = await videoManager.extractThumbnail(
        projectId: event.config.projectId,
        sourceFileName: event.config.sourceFileName!,
      );

      if (thumbnail == null) {
        emit(VideoThumbnailInitial());
        return;
      }

      emit(VideoThumbnailLoaded(
        id: event.config.projectId,
        thumbnail: thumbnail,
      ));
    });
  }
}
