import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadService _uploadService;

  UploadBloc(
    this._uploadService,
  ) : super(const UploadInitial([])) {
    on<UploadFileEvent>(_uploadFile);
  }

  Future<void> _uploadFile(event, emit) async {
    try {
      emit(const UploadInProgress());

      final List<VideoDataModel> files = await Future.wait(
        event.files.map<Future<VideoDataModel>>(
            (file) => _uploadService.processFile(XFile(file.path))),
      );

      await Future.wait(files.map((file) => _uploadService.moveFile(file)));

      emit(UploadSuccess(files));
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
