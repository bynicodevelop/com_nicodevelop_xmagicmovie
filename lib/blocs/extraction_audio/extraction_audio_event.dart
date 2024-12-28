part of 'extraction_audio_bloc.dart';

sealed class ExtractionAudioEvent extends Equatable {
  const ExtractionAudioEvent();

  @override
  List<Object> get props => [];
}

class OnExtractionAudioEvent extends ExtractionAudioEvent {
  final ConfigModel config;

  const OnExtractionAudioEvent({
    required this.config,
  });

  @override
  List<Object> get props => [
        config,
      ];
}
