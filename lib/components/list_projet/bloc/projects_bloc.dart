import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/project.dart';
import 'package:equatable/equatable.dart';

part 'projects_event.dart';
part 'projects_state.dart';

enum LoadingState {
  idle,
  loading,
  loaded,
  error,
}

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final Project project;

  ProjectsBloc(
    this.project,
  ) : super(const ProjectsInitial(
          [],
          LoadingState.idle,
        )) {
    on<LoadProjects>(
      (event, emit) async => project.loadProjects(event, emit, state),
    );
  }
}
