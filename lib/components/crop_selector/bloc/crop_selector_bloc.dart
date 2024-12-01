import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/update_constraints_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crop_selector_event.dart';
import 'crop_selector_state.dart';

class CropSelectorBloc extends Bloc<CropSelectorEvent, CropSelectorState> {
  CropSelectorBloc({
    required double minCropWidth,
    required double minCropHeight,
    required double maxWidth,
    required double maxHeight,
  }) : super(CropSelectorState(
          cropX: 50,
          cropY: 50,
          cropWidth: minCropWidth,
          cropHeight: minCropHeight,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          lockedAspectRatio: 0,
        )) {
    on<UpdateConstraintsEvent>((event, emit) {
      emit(state.copyWith(
        maxWidth: event.maxWidth,
        maxHeight: event.maxHeight,
      ));
    });

    on<UpdateCropPosition>((event, emit) {
      final newX =
          (state.cropX + event.dx).clamp(0.0, state.maxWidth - state.cropWidth);
      final newY = (state.cropY + event.dy)
          .clamp(0.0, state.maxHeight - state.cropHeight);
      emit(state.copyWith(cropX: newX, cropY: newY));
    });

    on<ResizeCropArea>((event, emit) {
      double newWidth = state.cropWidth +
          (event.adjustX ? -event.widthDelta : event.widthDelta);
      double newHeight = state.cropHeight +
          (event.adjustY ? -event.heightDelta : event.heightDelta);

      if (state.lockedAspectRatio != 0) {
        if (event.adjustX && !event.adjustY) {
          newHeight = newWidth / state.lockedAspectRatio!;
        } else if (event.adjustY && !event.adjustX) {
          newWidth = newHeight * state.lockedAspectRatio!;
        } else if (event.adjustX && event.adjustY) {
          newHeight = newWidth / state.lockedAspectRatio!;
        }
      }

      newWidth =
          newWidth.clamp(state.minCropWidth, state.maxWidth - state.cropX);
      newHeight =
          newHeight.clamp(state.minCropHeight, state.maxHeight - state.cropY);

      final newX = event.adjustX
          ? (state.cropX + event.widthDelta)
              .clamp(0.0, state.maxWidth - newWidth)
          : state.cropX;
      final newY = event.adjustY
          ? (state.cropY + event.heightDelta)
              .clamp(0.0, state.maxHeight - newHeight)
          : state.cropY;

      emit(state.copyWith(
        cropWidth: newWidth,
        cropHeight: newHeight,
        cropX: newX,
        cropY: newY,
      ));
    });

    on<SetAspectRatio>((event, emit) {
      double newWidth, newHeight, newX, newY;

      if (event.aspectRatio == 0) {
        emit(state.copyWith(lockedAspectRatio: 0));
        return;
      }

      if (event.aspectRatio <= 1) {
        newHeight = state.maxHeight;
        newWidth = newHeight * event.aspectRatio;

        if (newWidth > state.maxWidth) {
          newWidth = state.maxWidth;
          newHeight = newWidth / event.aspectRatio;
        }

        newX = (state.maxWidth - newWidth) / 2;
        newY = 0;
      } else {
        newWidth = state.maxWidth;
        newHeight = newWidth / event.aspectRatio;

        if (newHeight > state.maxHeight) {
          newHeight = state.maxHeight;
          newWidth = newHeight * event.aspectRatio;
        }

        newX = 0;
        newY = (state.maxHeight - newHeight) / 2;
      }

      emit(state.copyWith(
        cropWidth: newWidth,
        cropHeight: newHeight,
        cropX: newX,
        cropY: newY,
        lockedAspectRatio: event.aspectRatio,
      ));
    });
  }
}
