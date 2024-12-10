import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';

class Project {
  final FileManager fileManager;
  final ConfigService configService;
  final VideoManager videoManager;

  Project(
    this.fileManager,
    this.configService,
    this.videoManager,
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
      final videoDataModel = await videoManager.createVideoDataModel(
        event.config.projectId,
        event.config.sourceFileName,
      );

      emit(state.copyWith(
        lastUpdated: DateTime.now(),
        videoDataModel: videoDataModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          videoDataModel: null,
        ),
      );
    }
  }

  Future<void> deleteProject(event, emit, state) async {
    emit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    try {
      await fileManager.deleteDirectory(
        event.projectId,
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
        ),
      );
    }
  }
}
