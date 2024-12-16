part of 'open_file_bloc.dart';

sealed class OpenFileEvent extends Equatable {
  const OpenFileEvent();

  @override
  List<Object> get props => [];
}

class OnOpenFileEventOpen extends OpenFileEvent {
  final ConfigModel config;

  const OnOpenFileEventOpen({
    required this.config,
  });

  @override
  List<Object> get props => [
    config,
  ];
}