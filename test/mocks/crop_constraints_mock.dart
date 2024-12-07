class MockCropConstraintsEvent {
  final double maxWidth;
  final double maxHeight;

  MockCropConstraintsEvent({required this.maxWidth, required this.maxHeight});
}

class MockCropConstraintsState {
  double maxWidth = 0;
  double maxHeight = 0;
  double cropWidth = 0;
  double cropHeight = 0;

  MockCropConstraintsState copyWith({
    double? maxWidth,
    double? maxHeight,
    double? cropWidth,
    double? cropHeight,
  }) {
    return MockCropConstraintsState()
      ..maxWidth = maxWidth ?? this.maxWidth
      ..maxHeight = maxHeight ?? this.maxHeight
      ..cropWidth = cropWidth ?? this.cropWidth
      ..cropHeight = cropHeight ?? this.cropHeight;
  }
}
