part of 'tool_bloc.dart';

sealed class ToolState extends Equatable {
  final String toolName;
  final bool isPlayerTool;
  final bool isCropTool;

  const ToolState(
    this.toolName,
    this.isPlayerTool,
    this.isCropTool,
  );

  @override
  List<Object> get props => [
        toolName,
      ];
}

final class ToolInitial extends ToolState {
  @override
  final String toolName;
  @override
  final bool isPlayerTool;
  @override
  final bool isCropTool;

  const ToolInitial(
    this.toolName,
    this.isPlayerTool,
    this.isCropTool,
  ) : super(kPlayerTool, true, false);

  @override
  List<Object> get props => [
        toolName,
        isPlayerTool,
        isCropTool,
      ];
}
