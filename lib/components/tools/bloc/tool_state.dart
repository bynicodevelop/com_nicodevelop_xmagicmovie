part of 'tool_bloc.dart';

sealed class ToolState extends Equatable {
  final String toolName;
  final bool isPlayerTool;
  final bool isCropTool;
  final bool canRun;

  const ToolState(
    this.toolName,
    this.isPlayerTool,
    this.isCropTool, {
    this.canRun = false,
  });

  @override
  List<Object> get props => [
        toolName,
        isPlayerTool,
        isCropTool,
        canRun,
      ];
}

final class ToolInitial extends ToolState {
  const ToolInitial(
    super.toolName,
    super.isPlayerTool,
    super.isCropTool, {
    super.canRun = false,
  });
}
