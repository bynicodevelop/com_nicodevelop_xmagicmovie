part of 'transcription_renderer_bloc.dart';

sealed class TranscriptionRendererState extends Equatable {
  final LoadingState loadingState;
  final List<SentenceModel> sentences;

  const TranscriptionRendererState(
    this.loadingState,
    this.sentences,
  );

  @override
  List<Object> get props => [
        loadingState,
        sentences,
      ];
}

class TranscriptionRendererInitial extends TranscriptionRendererState {
  const TranscriptionRendererInitial({
    LoadingState loadingState = LoadingState.idle,
  }) : super(loadingState, const []);
}

class TranscriptionRendererLoading extends TranscriptionRendererState {
  const TranscriptionRendererLoading({
    LoadingState loadingState = LoadingState.loading,
  }) : super(loadingState, const []);
}

class TranscriptionRendererSuccess extends TranscriptionRendererState {
  const TranscriptionRendererSuccess({
    required List<SentenceModel> sentences,
    LoadingState loadingState = LoadingState.loaded,
  }) : super(loadingState, sentences);
}

class TranscriptionRendererError extends TranscriptionRendererState {
  const TranscriptionRendererError({
    LoadingState loadingState = LoadingState.error,
  }) : super(loadingState, const []);
}
