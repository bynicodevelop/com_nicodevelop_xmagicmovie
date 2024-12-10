import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'run_event.dart';
part 'run_state.dart';

class RunBloc extends Bloc<RunEvent, RunState> {
  final VideoManager _videoManager;

  RunBloc(
    this._videoManager,
  ) : super(RunInitialState()) {
    on<OnRunEvent>(_runEvent);
    on<OnRunInProgress>(_onRunInProgress);
    on<OnRunSuccess>(_onRunSuccess);
  }

  void _runEvent(event, emit) {
    emit(RunInitialState());

    // Afficher les données initiales pour vérification
    debugPrint("File Size (Base): ${event.fileSize.toJson()}");
    debugPrint("Crop (UX): ${event.crop.toJson()}");
    debugPrint("Video Size (UX): ${event.videoSize.toJson()}");

    // Valider les dimensions pour éviter des divisions par zéro
    if (event.videoSize.width == 0 || event.videoSize.height == 0) {
      throw Exception('Video size width or height (UX) cannot be zero.');
    }

    if (event.fileSize.width == 0 || event.fileSize.height == 0) {
      throw Exception('File size width or height (Base) cannot be zero.');
    }

    final VideoDataModel file = event.file;

    // Calculer les ratios d'échelle entre la vidéo UX et la vidéo réelle
    final double scaleX = event.fileSize.width / event.videoSize.width;
    final double scaleY = event.fileSize.height / event.videoSize.height;

    // Vérifier les ratios pour s'assurer qu'ils sont corrects
    debugPrint("Scale X: $scaleX");
    debugPrint("Scale Y: $scaleY");

    // Convertir les coordonnées et dimensions du recadrage UX vers les proportions de la vidéo de base
    final double finalCropX = event.crop.cropX * scaleX;
    final double finalCropY = event.crop.cropY * scaleY;
    final double finalCropWidth = event.crop.cropWidth * scaleX;
    final double finalCropHeight = event.crop.cropHeight * scaleY;

    // Créer un nouveau CropModel avec les dimensions converties
    final CropModel finalCrop = CropModel(
      cropX: finalCropX,
      cropY: finalCropY,
      cropWidth: finalCropWidth,
      cropHeight: finalCropHeight,
    );

    // Afficher les dimensions finales pour vérification
    debugPrint("Final Crop (Base): ${finalCrop.toJson()}");

    add(OnRunInProgress(
      file,
      event.fileSize,
      event.videoSize,
      event.crop,
      finalCrop,
    ));
  }

  Future<void> _onRunInProgress(event, emit) async {
    emit(RunInProgressState(
      file: event.file,
      videoSize: event.videoSize,
      crop: event.crop,
    ));

    await _videoManager.cropVideo(
      event.file,
      event.fileSize,
      event.finalCrop,
      (progress) => emit(RunProgressUpdate(
        progress: progress,
      )),
    );

    emit(const RunProgressUpdate(
      progress: 100,
    ));

    add(OnRunSuccess(
      event.file,
      event.fileSize,
      event.videoSize,
      event.crop,
      event.finalCrop,
    ));
  }

  void _onRunSuccess(event, emit) {
    emit(RunSuccessState());
  }
}
