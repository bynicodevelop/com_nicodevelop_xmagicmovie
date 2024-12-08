import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final FileManager fileManager = FileManager();

  final Directory workingDir = await fileManager.getWorkingDirectory();

  final VideoManager videoManager = VideoManager(
    workingDir: workingDir,
  );

  getIt.registerSingleton<VideoManager>(
    videoManager,
  );

  getIt.registerSingleton<UploadService>(
    UploadService(
      videoManager: videoManager,
      fileManager: fileManager,
    ),
  );
}
