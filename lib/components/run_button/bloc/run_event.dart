part of 'run_bloc.dart';

class RunEvent extends Equatable {
  final XFile file;
  final SizeModel fileSize;
  final SizeModel videoSize;
  final CropModel crop;
  final CropModel? finalCrop;

  const RunEvent(
    this.file,
    this.fileSize,
    this.videoSize,
    this.crop,
    this.finalCrop,
  );

  @override
  List<Object> get props => [
        file,
        fileSize,
        videoSize,
        crop,
      ];
}

class OnRunEvent extends RunEvent {
  const OnRunEvent(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
  );
}

class OnRunInProgress extends RunEvent {
  const OnRunInProgress(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
  );
}

class OnRunSuccess extends RunEvent {
  const OnRunSuccess(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
  );
}
