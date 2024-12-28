import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/sentence_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/transcription_service.dart';
import 'package:equatable/equatable.dart';

part 'transcription_renderer_event.dart';
part 'transcription_renderer_state.dart';

class TranscriptionRendererBloc
    extends Bloc<TranscriptionRendererEvent, TranscriptionRendererState> {
  final TranscriptionService transcriptionService;

  TranscriptionRendererBloc(
    this.transcriptionService,
  ) : super(const TranscriptionRendererInitial()) {
    on<OnTranscriptionRendererInitial>((event, emit) {
      emit(TranscriptionRendererSuccess(
        sentences: transcriptionService.createSentences(
          event.transcriptionModel,
        ),
      ));
    });
  }
}
