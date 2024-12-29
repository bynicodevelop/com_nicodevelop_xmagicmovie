part of 'transcription_bloc.dart';

sealed class TranscriptionEvent extends Equatable {
  const TranscriptionEvent();

  @override
  List<Object> get props => [];
}

class OnTranscriptionEvent extends TranscriptionEvent {
  final VideoDataModel videoDataModel;

  const OnTranscriptionEvent({
    required this.videoDataModel,
  });

  @override
  List<Object> get props => [videoDataModel];
}
