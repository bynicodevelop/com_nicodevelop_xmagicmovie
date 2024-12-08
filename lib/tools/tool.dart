import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';

class Tool {
  void playerTool(OnPlayerToolEvent event, emit, state) {
    emit(ToolInitial(
      kPlayerTool,
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
      kCropTool,
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
