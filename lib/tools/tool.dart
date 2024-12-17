import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';

class Tool {
  void resetTool(OnResetToolEvent event, emit, state) {
    emit(const ToolReset(
      false,
      false,
    ));
  }

  void initializeTool(OnInitializeToolEvent event, emit, state) {
    emit(const ToolInitialized(
      false,
      false,
    ));
  }

  void playerTool(OnPlayerToolEvent event, emit, state) {
    emit(ToolInitial(
      !state.isPlayerTool,
      state.isCropTool,
      canRun: _canRun(
        isCropTool: state.isCropTool,
      ),
    ));
  }

  void cropTool(OnCropToolEvent event, emit, state) {
    final bool isCropTool = !state.isCropTool;

    emit(ToolInitial(
      state.isPlayerTool,
      isCropTool,
      canRun: _canRun(
        isCropTool: isCropTool,
      ),
    ));
  }

  bool _canRun({
    required bool isCropTool,
  }) {
    return isCropTool;
  }
}
