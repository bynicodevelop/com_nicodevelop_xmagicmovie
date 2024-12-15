import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_event.dart';

class UpdateConstraintsEvent extends CropSelectorEvent {
  final double maxWidth;
  final double maxHeight;

  const UpdateConstraintsEvent(
    this.maxWidth,
    this.maxHeight,
  );

  UpdateConstraintsEvent copyWith({
    double? maxWidth,
    double? maxHeight,
  }) {
    return UpdateConstraintsEvent(
      maxWidth ?? this.maxWidth,
      maxHeight ?? this.maxHeight,
    );
  }

  @override
  List<Object> get props => [
        maxWidth,
        maxHeight,
      ];
}
