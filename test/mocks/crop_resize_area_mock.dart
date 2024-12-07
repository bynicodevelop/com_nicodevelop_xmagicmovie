class MockResizeCropAreaEvent {
  final double widthDelta;
  final double heightDelta;
  final bool adjustX;
  final bool adjustY;

  MockResizeCropAreaEvent({
    required this.widthDelta,
    required this.heightDelta,
    this.adjustX = false,
    this.adjustY = false,
  });
}

class MockResizeCropAreaState {
  final double cropX;
  final double cropY;
  final double cropWidth;
  final double cropHeight;
  final double minCropWidth;
  final double minCropHeight;
  final double maxWidth;
  final double maxHeight;
  final double lockedAspectRatio;

  MockResizeCropAreaState({
    this.cropX = 0,
    this.cropY = 0,
    this.cropWidth = 100,
    this.cropHeight = 100,
    this.minCropWidth = 50,
    this.minCropHeight = 50,
    this.maxWidth = 200,
    this.maxHeight = 200,
    this.lockedAspectRatio = 0,
  });

  MockResizeCropAreaState copyWith({
    double? cropX,
    double? cropY,
    double? cropWidth,
    double? cropHeight,
    double? minCropWidth,
    double? minCropHeight,
    double? maxWidth,
    double? maxHeight,
    double? lockedAspectRatio,
  }) {
    return MockResizeCropAreaState(
      cropX: cropX ?? this.cropX,
      cropY: cropY ?? this.cropY,
      cropWidth: cropWidth ?? this.cropWidth,
      cropHeight: cropHeight ?? this.cropHeight,
      minCropWidth: minCropWidth ?? this.minCropWidth,
      minCropHeight: minCropHeight ?? this.minCropHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      lockedAspectRatio: lockedAspectRatio ?? this.lockedAspectRatio,
    );
  }
}