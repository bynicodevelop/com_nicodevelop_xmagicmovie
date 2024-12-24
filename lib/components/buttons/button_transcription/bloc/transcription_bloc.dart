import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/transcription_service.dart';
import 'package:equatable/equatable.dart';

part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  final TranscriptionService transcriptionService;
  final ConfigService configService;

  TranscriptionBloc(
    this.transcriptionService,
    this.configService,
  ) : super(TranscriptionInitial()) {
    on<OnTranscriptionEvent>((event, emit) async {
      emit(TranscriptionLoading());

      if (event.videoDataModel.transcription != null) {
        emit(TranscriptionAlreadyTranscribed());
        return;
      }

      try {
        final TranscriptionModel transcription =
            await transcriptionService.transcribeAudioToText(
          event.videoDataModel.projectId,
          event.videoDataModel.uniqueFileName,
        );

        await configService.saveConfig(ConfigModel.fromJson({
          'projectId': event.videoDataModel.projectId,
          'sourceFileName': event.videoDataModel.uniqueFileName,
          'transcription': transcription.toJson(),
        }));

        emit(TranscriptionSuccess());
      } catch (e) {
        emit(TranscriptionFailure(
          message: e.toString(),
        ));
      }
    });
  }
}
