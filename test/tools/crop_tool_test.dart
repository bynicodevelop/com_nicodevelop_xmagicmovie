import 'package:flutter_test/flutter_test.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/crop_tool.dart';

import '../mocks/crop_aspect_ratio_mock.dart';
import '../mocks/crop_constraints_mock.dart';
import '../mocks/crop_position_mock.dart';
import '../mocks/crop_resize_area_mock.dart';

void main() {
  group('CropTool', () {
    test('updateConstraints updates state with new constraints', () {
      final cropTool = CropTool();
      final event = MockCropConstraintsEvent(maxWidth: 100, maxHeight: 200);
      final state = MockCropConstraintsState();
      emit(newState) {
        expect(newState.maxWidth, 100);
        expect(newState.maxHeight, 200);
        expect(newState.cropWidth, 100);
        expect(newState.cropHeight, 200);
      }

      cropTool.updateConstraints(event, emit, state);
    });

    test('updateCropPosition updates state with new crop position', () {
      final cropTool = CropTool();
      final event = MockCropPositionEvent(dx: 10, dy: 20);
      final state = MockCropPositionState(
        cropX: 50,
        cropY: 50,
        maxWidth: 200,
        maxHeight: 200,
        cropWidth: 100,
        cropHeight: 100,
      );
      emit(newState) {
        expect(newState.cropX, 60);
        expect(newState.cropY, 70);
      }

      cropTool.updateCropPosition(event, emit, state);
    });

    test('updateCropPosition clamps crop position within bounds', () {
      final cropTool = CropTool();
      final event = MockCropPositionEvent(dx: 200, dy: 200);
      final state = MockCropPositionState(
        cropX: 50,
        cropY: 50,
        maxWidth: 200,
        maxHeight: 200,
        cropWidth: 100,
        cropHeight: 100,
      );
      emit(newState) {
        expect(newState.cropX, 100);
        expect(newState.cropY, 100);
      }

      cropTool.updateCropPosition(event, emit, state);
    });

    test('updateConstraints updates state with new constraints', () {
      final cropTool = CropTool();
      final event = MockCropConstraintsEvent(maxWidth: 100, maxHeight: 200);
      final state = MockCropConstraintsState();
      emit(newState) {
        expect(newState.maxWidth, 100);
        expect(newState.maxHeight, 200);
        expect(newState.cropWidth, 100);
        expect(newState.cropHeight, 200);
      }

      cropTool.updateConstraints(event, emit, state);
    });

    test('updateCropPosition updates state with new crop position', () {
      final cropTool = CropTool();
      final event = MockCropPositionEvent(dx: 10, dy: 20);
      final state = MockCropPositionState(
        cropX: 50,
        cropY: 50,
        maxWidth: 200,
        maxHeight: 200,
        cropWidth: 100,
        cropHeight: 100,
      );
      emit(newState) {
        expect(newState.cropX, 60);
        expect(newState.cropY, 70);
      }

      cropTool.updateCropPosition(event, emit, state);
    });

    test('updateCropPosition clamps crop position within bounds', () {
      final cropTool = CropTool();
      final event = MockCropPositionEvent(dx: 200, dy: 200);
      final state = MockCropPositionState(
        cropX: 50,
        cropY: 50,
        maxWidth: 200,
        maxHeight: 200,
        cropWidth: 100,
        cropHeight: 100,
      );
      emit(newState) {
        expect(newState.cropX, 100);
        expect(newState.cropY, 100);
      }

      cropTool.updateCropPosition(event, emit, state);
    });

    test('resizeCropArea updates state with new crop area', () {
      final cropTool = CropTool();
      final event = MockResizeCropAreaEvent(widthDelta: 10, heightDelta: 20);
      final state = MockResizeCropAreaState(
        cropX: 50,
        cropY: 50,
        cropWidth: 100,
        cropHeight: 100,
        minCropWidth: 50,
        minCropHeight: 50,
        maxWidth: 200,
        maxHeight: 200,
      );
      emit(newState) {
        expect(newState.cropWidth, 110);
        expect(newState.cropHeight, 120);
      }

      cropTool.resizeCropArea(event, emit, state);
    });

    test('resizeCropArea clamps crop area within bounds', () {
      final cropTool = CropTool();
      final event = MockResizeCropAreaEvent(widthDelta: 200, heightDelta: 200);
      final state = MockResizeCropAreaState(
        cropX: 50,
        cropY: 50,
        cropWidth: 100,
        cropHeight: 100,
        minCropWidth: 50,
        minCropHeight: 50,
        maxWidth: 200,
        maxHeight: 200,
      );
      emit(newState) {
        expect(newState.cropWidth, 150);
        expect(newState.cropHeight, 150);
      }

      cropTool.resizeCropArea(event, emit, state);
    });
  });

  test('setAspectRation updates state with new aspect ratio', () {
    final cropTool = CropTool();
    final event = MockSetAspectRatioEvent(aspectRatio: 1.5);
    final state = MockSetAspectRatioState(
      maxWidth: 200,
      maxHeight: 200,
      cropWidth: 100,
      cropHeight: 100,
      cropX: 50,
      cropY: 50,
      lockedAspectRatio: 0,
    );
    emit(newState) {
      expect(newState.cropWidth, 200);
      expect(double.parse(newState.cropHeight.toStringAsFixed(2)), 133.33);
      expect(newState.cropX, 0);
      expect(double.parse(newState.cropY.toStringAsFixed(2)), 33.33);
      expect(newState.lockedAspectRatio, 1.5);
    }

    cropTool.setAspectRation(event, emit, state);
  });

  test('setAspectRation resets aspect ratio to 0', () {
    final cropTool = CropTool();
    final event = MockSetAspectRatioEvent(aspectRatio: 0.0);
    final state = MockSetAspectRatioState(
      maxWidth: 200.0,
      maxHeight: 200.0,
      cropWidth: 100.0,
      cropHeight: 100.0,
      cropX: 50.0,
      cropY: 50.0,
      lockedAspectRatio: 1.5,
    );
    emit(newState) {
      expect(newState.lockedAspectRatio, 0.0);
    }

    cropTool.setAspectRation(event, emit, state);
  });
}
