part of 'tool_bloc.dart';

sealed class ToolEvent extends Equatable {
  const ToolEvent();

  @override
  List<Object> get props => [];
}

class OnPlayerToolEvent extends ToolEvent {}

class OnCropToolEvent extends ToolEvent {}
