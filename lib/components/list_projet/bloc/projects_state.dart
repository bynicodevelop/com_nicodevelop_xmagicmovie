part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<ConfigModel> projects;
  final LoadingState loadingState;
  

  const ProjectsState(
    this.projects,
    this.loadingState,
  );

  ProjectsState copyWith({
    List<ConfigModel>? projects,
    LoadingState? loadingState,
  }) {
    return ProjectsState(
      projects ?? this.projects,
      loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        projects,
        loadingState,
      ];
}

final class ProjectsInitial extends ProjectsState {
  const ProjectsInitial(
    super.projects,
    super.loadingState,
  );
}
