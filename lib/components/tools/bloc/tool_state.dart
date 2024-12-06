part of 'tool_bloc.dart';

sealed class ToolState extends Equatable {
  final String toolName;
  final bool isPlayerTool;
  final bool isCropTool;
  final bool hasActiveTool;

  const ToolState(
    this.toolName,
    this.isPlayerTool,
    this.isCropTool, {
    this.hasActiveTool = false,
  });

  @override
  List<Object> get props => [
        toolName,
        isPlayerTool,
        isCropTool,
        hasActiveTool,
      ];
}

final class ToolInitial extends ToolState {
  @override
  final String toolName;
  @override
  final bool isPlayerTool;
  @override
  final bool isCropTool;
  @override
  final bool hasActiveTool;

  const ToolInitial(
    this.toolName,
    this.isPlayerTool,
    this.isCropTool, {
    this.hasActiveTool = false,
  }) : super(
          toolName,
          isPlayerTool,
          isCropTool,
          hasActiveTool: false,
        );

  @override
  List<Object> get props => [
        toolName,
        isPlayerTool,
        isCropTool,
        hasActiveTool,
      ];
}
