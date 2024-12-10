import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/project.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final Project project;

  ProjectBloc(
    this.project,
  ) : super(ProjectInitial(
          VideoDataModel(
            projectId: '',
            name: '',
            path: '',
            uniqueFileName: '',
            xfile: XFile(''),
            size: SizeModel(0, 0),
          ),
          DateTime.now(),
        )) {
    on<ProjectEvent>(
      (event, emit) async => project.loadProject(event, emit, state),
    );
  }
}
