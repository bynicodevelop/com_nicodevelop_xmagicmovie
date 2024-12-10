part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

final class LoadProject extends ProjectEvent {
  final ConfigModel config;

  const LoadProject(
    this.config,
  );
}
