class MockSetAspectRatioEvent {
  final double aspectRatio;

  MockSetAspectRatioEvent({required this.aspectRatio});
}

class MockSetAspectRatioState {
  final double cropX;
  final double cropY;
  final double cropWidth;
  final double cropHeight;
  final double maxWidth;
  final double maxHeight;
  final double lockedAspectRatio;

  MockSetAspectRatioState({
    this.cropX = 0,
    this.cropY = 0,
    this.cropWidth = 100,
    this.cropHeight = 100,
    this.maxWidth = 200,
    this.maxHeight = 200,
    this.lockedAspectRatio = 0,
  });

  MockSetAspectRatioState copyWith({
    double? cropX,
    double? cropY,
    double? cropWidth,
    double? cropHeight,
    double? maxWidth,
    double? maxHeight,
    double? lockedAspectRatio,
  }) {
    return MockSetAspectRatioState(
      cropX: cropX ?? this.cropX,
      cropY: cropY ?? this.cropY,
      cropWidth: cropWidth ?? this.cropWidth,
      cropHeight: cropHeight ?? this.cropHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      lockedAspectRatio: lockedAspectRatio ?? this.lockedAspectRatio,
    );
  }
}
