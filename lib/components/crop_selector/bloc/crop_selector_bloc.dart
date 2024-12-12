import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/update_constraints_event.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/crop_tool.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crop_selector_event.dart';
import 'crop_selector_state.dart';

class CropSelectorBloc extends Bloc<CropSelectorEvent, CropSelectorState> {
  final CropTool _cropTool;

  CropSelectorBloc(
    this._cropTool, {
    required double minCropWidth,
    required double minCropHeight,
    required double maxWidth,
    required double maxHeight,
  }) : super(CropSelectorState(
          cropX: 0,
          cropY: 0,
          cropWidth: minCropWidth,
          cropHeight: minCropHeight,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          lockedAspectRatio: 0,
        )) {
    on<UpdateConstraintsEvent>(_handleEvent);
    on<UpdateCropPosition>(_handleEvent);
    on<ResizeCropArea>(_handleEvent);
    on<SetAspectRatio>(_handleEvent);
    on<StopCropActionEvent>(_handleEvent);
  }

  void _handleEvent(CropSelectorEvent event, Emitter<CropSelectorState> emit) {
    print(event);
    if (event is StopCropActionEvent) {
      return;
    }

    if (event is UpdateConstraintsEvent) {
      _cropTool.updateConstraints(event, emit, state);
    } else if (event is UpdateCropPosition) {
      _cropTool.updateCropPosition(event, emit, state);
    } else if (event is ResizeCropArea) {
      _cropTool.resizeCropArea(event, emit, state);
    } else if (event is SetAspectRatio) {
      _cropTool.setAspectRation(event, emit, state);
    }
  }
}
