import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(const PlayerInitial()) {
    on<InitializeVideo>(_onInitializeVideo);
    on<UpdateConstraintsEvent>(_onUpdateSize);
  }

  Future<void> _onInitializeVideo(
      InitializeVideo event, Emitter<VideoState> emit) async {
    final controller = VideoPlayerController.file(File(event.file.path));
    await controller.initialize();
    emit(state.copyWith(
      controller: controller,
      isInitialized: true,
      isPlaying: false,
    ));
  }

  Future<void> _onUpdateSize(
      UpdateConstraintsEvent event, Emitter<VideoState> emit) async {
    emit(state.copyWith(
      maxWidth: event.maxWidth,
      maxHeight: event.maxHeight,
    ));
  }
}
