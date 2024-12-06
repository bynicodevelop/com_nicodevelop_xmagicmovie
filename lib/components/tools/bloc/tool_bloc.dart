import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:equatable/equatable.dart';

part 'tool_event.dart';
part 'tool_state.dart';

class ToolBloc extends Bloc<ToolEvent, ToolState> {
  ToolBloc()
      : super(const ToolInitial(
          kPlayerTool,
          true,
          false,
        )) {
    on<OnPlayerToolEvent>(
      _onPlayerTool,
    );

    on<OnCropToolEvent>(
      _onCropTool,
    );
  }

  bool hasActiveTool({
    required bool isCropTool,
  }) {
    return isCropTool;
  }

  _onPlayerTool(OnPlayerToolEvent event, Emitter<ToolState> emit) {
    emit(ToolInitial(
      kPlayerTool,
      !state.isPlayerTool,
      state.isCropTool,
      hasActiveTool: hasActiveTool(
        isCropTool: state.isCropTool,
      ),
    ));
  }

  _onCropTool(OnCropToolEvent event, Emitter<ToolState> emit) {
    final bool isCropTool = !state.isCropTool;

    emit(ToolInitial(
      kCropTool,
      state.isPlayerTool,
      isCropTool,
      hasActiveTool: hasActiveTool(
        isCropTool: isCropTool,
      ),
    ));
  }
}
