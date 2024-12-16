import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:equatable/equatable.dart';

part 'open_file_event.dart';
part 'open_file_state.dart';

class OpenFileBloc extends Bloc<OpenFileEvent, OpenFileState> {
  final VideoManager videoManager;

  OpenFileBloc({
    required this.videoManager,
  }) : super(const OpenFileInitial()) {
    on<OnOpenFileEventOpen>((event, emit) async {
      final String? finalPath = await videoManager.getCoppedVideoPath(
        event.config.projectId,
        event.config.sourceFileName!,
      );

      emit(OpenFileSuccess(
        finalPath: finalPath ?? '',
      ));
    });
  }
}
