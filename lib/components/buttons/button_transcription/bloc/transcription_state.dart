part of 'transcription_bloc.dart';

sealed class TranscriptionState extends Equatable {
  const TranscriptionState();

  @override
  List<Object> get props => [];
}

final class TranscriptionInitial extends TranscriptionState {}

final class TranscriptionLoading extends TranscriptionState {}

final class TranscriptionSuccess extends TranscriptionState {
  final TranscriptionModel transcription;

  const TranscriptionSuccess({
    required this.transcription,
  });

  @override
  List<Object> get props => [
        transcription,
      ];
}

final class TranscriptionAlreadyTranscribed extends TranscriptionState {
  final TranscriptionModel transcription;

  const TranscriptionAlreadyTranscribed({
    required this.transcription,
  });

  @override
  List<Object> get props => [
        transcription,
      ];
}

final class TranscriptionFailure extends TranscriptionState {
  final String message;

  const TranscriptionFailure({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
