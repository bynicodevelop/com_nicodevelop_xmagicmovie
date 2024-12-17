import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadService uploadService;
  final ConfigService configService;
  final VideoManager videoManager;

  UploadBloc(
    this.uploadService,
    this.configService,
    this.videoManager,
  ) : super(const UploadInitial([])) {
    on<UploadFileEvent>(_uploadFile);
  }

  Future<void> _uploadFile(event, emit) async {
    try {
      emit(const UploadInProgress());

      final List<VideoDataModel> files = await Future.wait(
        event.files.map<Future<VideoDataModel>>((file) async {
          final VideoDataModel videoDataModel =
              await videoManager.processFile(XFile(file.path));

          await configService.saveConfig(ConfigModel(
            projectId: videoDataModel.projectId,
            sourceFileName: videoDataModel.uniqueFileName,
          ));

          return videoDataModel;
        }),
      );

      await Future.wait(
        files.map(
          (file) => uploadService.moveFile(file),
        ),
      );

      emit(UploadSuccess(files));
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
