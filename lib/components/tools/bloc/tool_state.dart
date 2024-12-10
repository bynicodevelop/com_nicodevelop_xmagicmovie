part of 'tool_bloc.dart';

sealed class ToolState extends Equatable {
  final bool isPlayerTool;
  final bool isCropTool;
  final bool canRun;

  const ToolState(
    this.isPlayerTool,
    this.isCropTool, {
    this.canRun = false,
  });

  @override
  List<Object> get props => [
        isPlayerTool,
        isCropTool,
        canRun,
      ];
}

final class ToolInitial extends ToolState {
  const ToolInitial(
    super.isPlayerTool,
    super.isCropTool, {
    super.canRun = false,
  });
}

final class ToolInitialized extends ToolState {
  const ToolInitialized(
    super.isPlayerTool,
    super.isCropTool, {
    super.canRun = false,
  });
}

final class ToolReset extends ToolState {
  const ToolReset(
    super.isPlayerTool,
    super.isCropTool, {
    super.canRun = false,
  });
}
