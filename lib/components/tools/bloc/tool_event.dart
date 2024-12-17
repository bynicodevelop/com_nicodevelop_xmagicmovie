part of 'tool_bloc.dart';

sealed class ToolEvent extends Equatable {
  const ToolEvent();

  @override
  List<Object> get props => [];
}

class OnResetToolEvent extends ToolEvent {}

class OnInitializeToolEvent extends ToolEvent {}

class OnPlayerToolEvent extends ToolEvent {}

class OnCropToolEvent extends ToolEvent {}
