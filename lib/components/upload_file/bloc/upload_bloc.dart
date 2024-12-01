import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/file_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:equatable/equatable.dart';
import 'package:cross_file/cross_file.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UplaodService _uplaodService;

  UploadBloc(
    this._uplaodService,
  ) : super(const UploadState([])) {
    on<UploadFileEvent>((event, emit) async {
      final List<FileModel> filesName = await Future.wait(
        event.files.map((file) async {
          final String uniqueFileName =
              await FileManager.generateUniqueFileName(file);

          final Directory workingDir = await FileManager.getWorkingDirectory();
          final String filePath = '${workingDir.path}/$uniqueFileName';

          await file.saveTo(filePath);

          return FileModel(
            name: file.name,
            path: filePath,
            uniqueFileName: uniqueFileName,
            xfile: file,
          );
        }),
      );

      await Future.wait(
        filesName.map((file) async {
          await _uplaodService.moveFile(file);
        }),
      );
    });
  }
}
