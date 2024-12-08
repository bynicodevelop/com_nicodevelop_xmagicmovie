import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';

class ConfigService {
  final FileManager fileManager;

  final String _configFileName = 'config.json';

  const ConfigService({
    required this.fileManager,
  });

  Future<void> saveConfig(
    ConfigModel config,
  ) async {
    final Directory projectPath = await fileManager.getWorkingDirectory();

    await fileManager.saveJsonFile(
      '${projectPath.path}/${config.projectId}',
      _configFileName,
      config.toJson(),
    );
  }
}
