import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:cross_file/cross_file.dart';

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
      final videoPath = await fileManager.getFilePath(
        event.config.projectId,
        event.config.sourceFileName,
      );
      final XFile videoFile = XFile(videoPath);

      emit(state.copyWith(
        lastUpdated: DateTime.now(),
        videoDataModel: VideoDataModel(
          projectId: event.config.projectId,
          name: event.config.sourceFileName ?? '',
          path: videoPath,
          uniqueFileName: event.config.sourceFileName ?? '',
          xfile: videoFile,
          size: await videoManager.getVideoSize(videoFile),
        ),
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
