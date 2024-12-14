part of 'loader_bloc.dart';

sealed class LoaderState extends Equatable {
  const LoaderState();
  
  @override
  List<Object> get props => [];
}

final class LoaderIdleState extends LoaderState {}

final class LoaderInProgressState extends LoaderState {}
