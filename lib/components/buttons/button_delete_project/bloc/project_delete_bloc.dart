import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/project.dart';
import 'package:equatable/equatable.dart';

part 'project_delete_event.dart';
part 'project_delete_state.dart';

class ProjectDeletionBloc
    extends Bloc<ProjectDeleteEvent, ProjectDeletionState> {
  final Project project;

  ProjectDeletionBloc(
    this.project,
  ) : super(const DeleteInitial()) {
    on<OnDeleteProject>((event, emit) async => project.deleteProject(
          event,
          emit,
          state,
        ));
  }
}
