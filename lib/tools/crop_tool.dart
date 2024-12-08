class CropTool {
  void updateConstraints(event, emit, state) {
    emit(state.copyWith(
      maxWidth: event.maxWidth,
      maxHeight: event.maxHeight,
      cropWidth: event.maxWidth,
      cropHeight: event.maxHeight,
    ));
  }

  updateCropPosition(event, emit, state) {
    final newX =
        (state.cropX + event.dx).clamp(0.0, state.maxWidth - state.cropWidth);
    final newY =
        (state.cropY + event.dy).clamp(0.0, state.maxHeight - state.cropHeight);

    emit(state.copyWith(
      cropX: newX,
      cropY: newY,
    ));
  }

  void resizeCropArea(event, emit, state) {
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

    // Calcul des bornes effectives pour éviter des erreurs de clamp
    final double effectiveMaxWidth = state.maxWidth - state.cropX;
    final double effectiveMinWidth = state.minCropWidth <= effectiveMaxWidth
        ? state.minCropWidth
        : effectiveMaxWidth;

    final double effectiveMaxHeight = state.maxHeight - state.cropY;
    final double effectiveMinHeight = state.minCropHeight <= effectiveMaxHeight
        ? state.minCropHeight
        : effectiveMaxHeight;

    // Appliquer clamp avec les bornes ajustées
    newWidth = newWidth.clamp(effectiveMinWidth, effectiveMaxWidth);
    newHeight = newHeight.clamp(effectiveMinHeight, effectiveMaxHeight);

    // Calcul des nouvelles positions
    final double newX = event.adjustX
        ? (state.cropX + event.widthDelta).clamp(0.0, state.maxWidth - newWidth)
        : state.cropX;

    final double newY = event.adjustY
        ? (state.cropY + event.heightDelta)
            .clamp(0.0, state.maxHeight - newHeight)
        : state.cropY;

    // Émettre le nouvel état avec les valeurs mises à jour
    emit(state.copyWith(
      cropWidth: newWidth,
      cropHeight: newHeight,
      cropX: newX,
      cropY: newY,
    ));
  }

  setAspectRation(event, emit, state) {
    double newWidth, newHeight, newX, newY;

    if (event.aspectRatio == 0) {
      emit(state.copyWith(lockedAspectRatio: 0.0));
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
  }
}
