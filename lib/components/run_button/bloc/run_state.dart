part of 'run_bloc.dart';

sealed class RunState extends Equatable {
  const RunState();

  @override
  List<Object> get props => [];
}

final class RunInitial extends RunState {}

final class RunInProgress extends RunState {
  final VideoDataModel file;
  final SizeModel videoSize;
  final CropModel crop;

  const RunInProgress({
    required this.file,
    required this.videoSize,
    required this.crop,
  });
}

final class RunSuccess extends RunState {}
