import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';

class ConfigService {
  final FileManager fileManager;
  final String _configFileName = 'config.json';

  const ConfigService({
    required this.fileManager,
  });

  Future<List<ConfigModel>> loadConfigs() async {
    final Directory projectPath = await fileManager.getWorkingDirectory();
    final List<ConfigModel> configs = <ConfigModel>[];
    final List<FileSystemEntity> entities = projectPath.listSync();

    for (final FileSystemEntity entity in entities) {
      if (entity is Directory) {
        final File configFile = File('${entity.path}/$_configFileName');

        if (configFile.existsSync()) {
          final Map<String, dynamic> configJson =
              await fileManager.readJsonFile(configFile.path);

          configs.add(ConfigModel.fromJson(configJson));
        }
      }
    }

    return configs;
  }

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
