part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

final class LoadProjects extends ProjectsEvent {
  const LoadProjects();
}
