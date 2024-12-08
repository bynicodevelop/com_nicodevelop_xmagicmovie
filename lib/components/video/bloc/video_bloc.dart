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
    on<OnPlayEvent>(_onPlay);
    on<OnPauseEvent>(_onPause);
  }

  Future<void> _onInitializeVideo(
    InitializeVideo event,
    Emitter<VideoState> emit,
  ) async {
    final controller = VideoPlayerController.file(File(event.file.path));
    await controller.initialize();
    emit(state.copyWith(
      controller: controller,
      isInitialized: true,
      isPlaying: false,
    ));
  }

  void _onUpdateSize(
    UpdateConstraintsEvent event,
    Emitter<VideoState> emit,
  ) {
    emit(state.copyWith(
      maxWidth: event.maxWidth,
      maxHeight: event.maxHeight,
    ));
  }

  Future<void> _onPlay(
    OnPlayEvent event,
    Emitter<VideoState> emit,
  ) async {
    if (state.controller == null) return;

    await state.controller!.play();
    emit(state.copyWith(
      isPlaying: true,
    ));
  }

  Future<void> _onPause(
    OnPauseEvent event,
    Emitter<VideoState> emit,
  ) async {
    if (state.controller == null) return;

    await state.controller!.pause();
    emit(state.copyWith(
      isPlaying: false,
    ));
  }
}
