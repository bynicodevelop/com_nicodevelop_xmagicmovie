part of 'extraction_audio_bloc.dart';

sealed class ExtractionAudioState extends Equatable {
  const ExtractionAudioState();

  @override
  List<Object> get props => [];
}

final class ExtractionAudioInitial extends ExtractionAudioState {}

final class ExtractionAudioLoading extends ExtractionAudioState {}

final class ExtractionAudioSuccess extends ExtractionAudioState {}

final class ExtractionAudioFailure extends ExtractionAudioState {}
