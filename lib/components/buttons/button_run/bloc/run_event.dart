part of 'run_bloc.dart';

class RunEvent extends Equatable {
  final VideoDataModel file;
  final SizeModel fileSize;
  final SizeModel videoSize;
  final CropModel crop;
  final CropModel? finalCrop;
  final double zoomScale;

  const RunEvent(
    this.file,
    this.fileSize,
    this.videoSize,
    this.crop,
    this.finalCrop,
    this.zoomScale,
  );

  @override
  List<Object> get props => [
        file,
        fileSize,
        videoSize,
        crop,
        zoomScale,
      ];
}

class OnRunEvent extends RunEvent {
  const OnRunEvent(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
    super.zoomScale,
  );
}

class OnRunInProgress extends RunEvent {
  const OnRunInProgress(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
    super.zoomScale,
  );
}

class OnRunSuccess extends RunEvent {
  final String finalPath;

  const OnRunSuccess(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.finalCrop,
    super.zoomScale,
    this.finalPath,
  );

  @override
  List<Object> get props => [
        file,
        fileSize,
        videoSize,
        crop,
        zoomScale,
        finalPath,
      ];
}

class OnResetEvent extends RunEvent {
  const OnResetEvent(
    super.file,
    super.fileSize,
    super.videoSize,
    super.crop,
    super.zoomScale,
    super.finalCrop,
  );
}
