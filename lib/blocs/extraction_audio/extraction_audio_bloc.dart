import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:equatable/equatable.dart';

part 'extraction_audio_event.dart';
part 'extraction_audio_state.dart';

class ExtractionAudioBloc
    extends Bloc<ExtractionAudioEvent, ExtractionAudioState> {
  final VideoManager videoManager;

  ExtractionAudioBloc(
    this.videoManager,
  ) : super(ExtractionAudioInitial()) {
    on<OnExtractionAudioEvent>((event, emit) async {
      emit(ExtractionAudioLoading());
      
      try {
        await videoManager.extractAudio(
          event.config.projectId,
          event.config.sourceFileName!,
        );
        emit(ExtractionAudioSuccess());
      } catch (e) {
        emit(ExtractionAudioFailure());
      }
    });
  }
}
