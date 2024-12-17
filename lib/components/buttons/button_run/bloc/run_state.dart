part of 'run_bloc.dart';

sealed class RunState extends Equatable {
  const RunState();

  @override
  List<Object> get props => [];
}

final class RunInitialState extends RunState {}

final class RunInProgressState extends RunState {
  final VideoDataModel file;
  final SizeModel videoSize;
  final CropModel crop;

  const RunInProgressState({
    required this.file,
    required this.videoSize,
    required this.crop,
  });
}

final class RunSuccessState extends RunState {
  final String finalPath;

  const RunSuccessState({
    required this.finalPath,
  });
}

class RunProgressUpdate extends RunState {
  final int progress;

  const RunProgressUpdate({
    required this.progress,
  });

  @override
  List<Object> get props => [
        progress,
      ];
}

class RunFailureState extends RunState {
  final String error;

  const RunFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
