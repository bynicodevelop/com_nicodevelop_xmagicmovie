import 'package:equatable/equatable.dart';

class CropSelectorEvent extends Equatable {
  const CropSelectorEvent();

  @override
  List<Object> get props => [];
}

class UpdateCropPosition extends CropSelectorEvent {
  final double dx;
  final double dy;

  const UpdateCropPosition(this.dx, this.dy);

  @override
  List<Object> get props => [dx, dy];
}

class ResizeCropArea extends CropSelectorEvent {
  final double widthDelta;
  final double heightDelta;
  final bool adjustX; // Si vrai, ajuste `cropX`
  final bool adjustY; // Si vrai, ajuste `cropY`

  const ResizeCropArea(
    this.widthDelta,
    this.heightDelta, {
    this.adjustX = false,
    this.adjustY = false,
  });

  @override
  List<Object> get props => [widthDelta, heightDelta, adjustX, adjustY];
}

class StopCropActionEvent extends CropSelectorEvent {}

class SetAspectRatio extends CropSelectorEvent {
  final double aspectRatio;

  const SetAspectRatio(
    this.aspectRatio,
  );

  @override
  List<Object> get props => [
        aspectRatio,
      ];
}
