import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/tool.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('playerTool updates state with new tool', () {
    final tool = Tool();
    final event = OnPlayerToolEvent();
    const state = ToolInitial(
      kPlayerTool,
      false,
      false,
    );
    emit(newState) {
      expect(newState.isPlayerTool, true);
      expect(newState.isCropTool, false);
    }

    tool.playerTool(
      event,
      emit,
      state,
    );
  });

  test('cropTool updates state with new tool', () {
    final tool = Tool();
    final event = OnCropToolEvent();
    const state = ToolInitial(
      kPlayerTool,
      false,
      false,
    );
    emit(newState) {
      expect(newState.isPlayerTool, false);
      expect(newState.isCropTool, true);
    }

    tool.cropTool(
      event,
      emit,
      state,
    );
  });
}
