import 'package:equatable/equatable.dart';

class CropSelectorState extends Equatable {
  final double cropX;
  final double cropY;
  final double cropWidth;
  final double cropHeight;
  final double maxWidth;
  final double maxHeight;
  final double minCropWidth;
  final double minCropHeight;
  final double? lockedAspectRatio;

  const CropSelectorState({
    this.cropX = 50,
    this.cropY = 50,
    this.cropWidth = 250,
    this.cropHeight = 150,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.minCropWidth = 250,
    this.minCropHeight = 150,
    this.lockedAspectRatio,
  });

  CropSelectorState copyWith({
    double? cropX,
    double? cropY,
    double? cropWidth,
    double? cropHeight,
    double? maxWidth,
    double? maxHeight,
    double? minCropWidth,
    double? minCropHeight,
    double? lockedAspectRatio,
  }) {
    return CropSelectorState(
      cropX: cropX ?? this.cropX,
      cropY: cropY ?? this.cropY,
      cropWidth: cropWidth ?? this.cropWidth,
      cropHeight: cropHeight ?? this.cropHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      minCropWidth: minCropWidth ?? this.minCropWidth,
      minCropHeight: minCropHeight ?? this.minCropHeight,
      lockedAspectRatio: lockedAspectRatio ?? this.lockedAspectRatio,
    );
  }

  @override
  List<Object?> get props => [
        cropX,
        cropY,
        cropWidth,
        cropHeight,
        maxWidth,
        maxHeight,
        minCropWidth,
        minCropHeight,
        lockedAspectRatio,
      ];
}
