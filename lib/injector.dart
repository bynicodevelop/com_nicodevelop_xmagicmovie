import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final FileManager fileManager = FileManager();

  final ConfigService configService = ConfigService(
    fileManager: fileManager,
  );

  final VideoManager videoManager = VideoManager(
    fileManager: fileManager,
  );

  getIt.registerSingleton<FileManager>(
    fileManager,
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

  getIt.registerSingleton<ConfigService>(
    configService,
  );
}
