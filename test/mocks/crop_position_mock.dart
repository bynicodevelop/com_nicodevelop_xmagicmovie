class MockCropPositionEvent {
  final double dx;
  final double dy;

  MockCropPositionEvent({required this.dx, required this.dy});
}

class MockCropPositionState {
  double cropX;
  double cropY;
  double maxWidth;
  double maxHeight;
  double cropWidth;
  double cropHeight;

  MockCropPositionState({
    required this.cropX,
    required this.cropY,
    required this.maxWidth,
    required this.maxHeight,
    required this.cropWidth,
    required this.cropHeight,
  });

  MockCropPositionState copyWith({
    double? cropX,
    double? cropY,
  }) {
    return MockCropPositionState(
      cropX: cropX ?? this.cropX,
      cropY: cropY ?? this.cropY,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      cropWidth: cropWidth,
      cropHeight: cropHeight,
    );
  }
}
