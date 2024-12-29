part of 'transcription_renderer_bloc.dart';

sealed class TranscriptionRendererEvent extends Equatable {
  const TranscriptionRendererEvent();

  @override
  List<Object> get props => [];
}

class OnTranscriptionRendererInitial extends TranscriptionRendererEvent {
  final TranscriptionModel transcriptionModel;

  const OnTranscriptionRendererInitial({
    required this.transcriptionModel,
  });

  @override
  List<Object> get props => [
        transcriptionModel,
      ];
}
