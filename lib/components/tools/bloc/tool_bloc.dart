import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/tool.dart';
import 'package:equatable/equatable.dart';

part 'tool_event.dart';
part 'tool_state.dart';

class ToolBloc extends Bloc<ToolEvent, ToolState> {
  final Tool tool;

  ToolBloc(
    this.tool,
  ) : super(const ToolInitial(false, false)) {
    on<OnInitializeToolEvent>(_onInitializeTool);
    on<OnPlayerToolEvent>(_onPlayerTool);
    on<OnCropToolEvent>(_onCropTool);
    on<OnResetToolEvent>(_onResetTool);
  }

  _onInitializeTool(OnInitializeToolEvent event, Emitter<ToolState> emit) {
    tool.initializeTool(event, emit, state);
  }

  _onResetTool(OnResetToolEvent event, Emitter<ToolState> emit) {
    tool.resetTool(event, emit, state);
  }

  _onPlayerTool(OnPlayerToolEvent event, Emitter<ToolState> emit) {
    tool.playerTool(event, emit, state);
  }

  _onCropTool(OnCropToolEvent event, Emitter<ToolState> emit) {
    tool.cropTool(event, emit, state);
  }
}
