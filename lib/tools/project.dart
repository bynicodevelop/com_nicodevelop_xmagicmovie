import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:cross_file/cross_file.dart';

class Project {
  final FileManager fileManager;
  final ConfigService configService;

  Project(
    this.fileManager,
    this.configService,
  );

  Future<void> loadProjects(event, emit, state) async {
    emit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    try {
      final projects = await configService.loadConfigs();

      emit(
        state.copyWith(
          projects: projects,
          loadingState: LoadingState.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          projects: [],
          loadingState: LoadingState.error,
        ),
      );
    }
  }

  Future<void> loadProject(event, emit, state) async {
    try {
      final videoPath = await fileManager.getFilePath(
        event.config.projectId,
        event.config.sourceFileName,
      );
      final XFile videoFile = XFile(videoPath);

      emit(
        state.copyWith(
          videoFile: videoFile,
        ),
      );
    } catch (e) {
      // Gérer l'erreur en émettant un état avec videoFile à null
      emit(
        state.copyWith(
          videoFile: null,
        ),
      );
    }
  }
}
