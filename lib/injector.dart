import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final Directory workingDir = await FileManager.getWorkingDirectory();

  getIt.registerSingleton<VideoManager>(
    VideoManager(
      workingDir: workingDir,
    ),
  );

  getIt.registerSingleton<UplaodService>(
    UplaodService(),
  );
}
