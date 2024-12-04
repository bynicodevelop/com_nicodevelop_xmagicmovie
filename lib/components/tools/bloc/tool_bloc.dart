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

  _onPlayerTool(OnPlayerToolEvent event, Emitter<ToolState> emit) {
    emit(ToolInitial(
      kPlayerTool,
      !state.isPlayerTool,
      state.isCropTool,
    ));
  }

  _onCropTool(OnCropToolEvent event, Emitter<ToolState> emit) {
    emit(ToolInitial(
      kCropTool,
      state.isPlayerTool,
      !state.isCropTool,
    ));
  }
}
