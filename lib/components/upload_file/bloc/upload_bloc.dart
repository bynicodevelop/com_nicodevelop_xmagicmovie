import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UplaodService _uplaodService;
  final VideoManager _videoManager;

  UploadBloc(
    this._uplaodService,
    this._videoManager,
  ) : super(const UploadState([])) {
    on<UploadFileEvent>((event, emit) async {
      final List<VideoDataModel> files = await Future.wait(
        event.files.map((file) async {
          final String uniqueFileName =
              await FileManager.generateUniqueFileName(file);
          final SizeModel size = await _videoManager.getVideoSize(file);

          final Directory workingDir = await FileManager.getWorkingDirectory();
          final String filePath = '${workingDir.path}/$uniqueFileName';

          // await file.saveTo(filePath);

          return VideoDataModel(
            name: file.name,
            path: filePath,
            uniqueFileName: uniqueFileName,
            xfile: file,
            size: size,
          );
        }),
      );

      debugPrint(files[0].toJson().toString());

      // await Future.wait(
      //   files.map((file) async {
      //     await _uplaodService.moveFile(file);
      //   }),
      // );

      emit(UploadState(
        files,
      ));
    });
  }
}
