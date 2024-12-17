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
    double newWidth = state.cropWidth;
    double newHeight = state.cropHeight;
    double newX = state.cropX;
    double newY = state.cropY;

    // Redimensionner depuis le coin supérieur-gauche
    if (event.adjustX && event.adjustY) {
      newWidth = (state.cropWidth - event.widthDelta)
          .clamp(state.minCropWidth, state.maxWidth - state.cropX);
      newHeight = (state.cropHeight - event.heightDelta)
          .clamp(state.minCropHeight, state.maxHeight - state.cropY);
      newX = (state.cropX + event.widthDelta)
          .clamp(0.0, state.maxWidth - newWidth);
      newY = (state.cropY + event.heightDelta)
          .clamp(0.0, state.maxHeight - newHeight);
    }

    // Redimensionner depuis le coin supérieur-droit
    else if (!event.adjustX && event.adjustY) {
      newWidth = (state.cropWidth + event.widthDelta)
          .clamp(state.minCropWidth, state.maxWidth - state.cropX);
      newHeight = (state.cropHeight - event.heightDelta)
          .clamp(state.minCropHeight, state.maxHeight - state.cropY);
      newY = (state.cropY + event.heightDelta)
          .clamp(0.0, state.maxHeight - newHeight);
    }

    // Redimensionner depuis le coin inférieur-gauche
    else if (event.adjustX && !event.adjustY) {
      newWidth = (state.cropWidth - event.widthDelta)
          .clamp(state.minCropWidth, state.maxWidth - state.cropX);
      newHeight = (state.cropHeight + event.heightDelta)
          .clamp(state.minCropHeight, state.maxHeight - state.cropY);
      newX = (state.cropX + event.widthDelta)
          .clamp(0.0, state.maxWidth - newWidth);
    }

    // Redimensionner depuis le coin inférieur-droit
    else if (!event.adjustX && !event.adjustY) {
      newWidth = (state.cropWidth + event.widthDelta)
          .clamp(state.minCropWidth, state.maxWidth - state.cropX);
      newHeight = (state.cropHeight + event.heightDelta)
          .clamp(state.minCropHeight, state.maxHeight - state.cropY);
    }

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
