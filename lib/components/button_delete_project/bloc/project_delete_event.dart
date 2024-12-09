part of 'project_delete_bloc.dart';

sealed class ProjectDeleteEvent extends Equatable {
  const ProjectDeleteEvent();

  @override
  List<Object> get props => [];
}

final class OnDeleteProject extends ProjectDeleteEvent {
  final String projectId;

  const OnDeleteProject(
    this.projectId,
  );

  @override
  List<Object> get props => [
        projectId,
      ];
}
