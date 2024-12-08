import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'upload_service_test.mocks.dart';

void main() {
  late ConfigService configService;
  late MockFileManager mockFileManager;

  setUp(() {
    mockFileManager = MockFileManager();
    configService = ConfigService(
      fileManager: mockFileManager,
    );
  });

  group('ConfigService', () {
    test('saveConfig should save configuration file successfully', () async {
      // Arrange
      final config = ConfigModel(
        projectId: '12345',
      );

      final mockDirectory = Directory('/mock/path');

      // Assurez-vous que le mock retourne un Future<Directory>
      when(mockFileManager.getWorkingDirectory())
          .thenAnswer((_) async => mockDirectory);

      when(mockFileManager.saveJsonFile(
        '${mockDirectory.path}/${config.projectId}',
        'config.json',
        config.toJson(),
      )).thenAnswer((_) async => Future.value(null));

      // Act
      await configService.saveConfig(config);

      // Assert
      verify(mockFileManager.getWorkingDirectory()).called(1);
      verify(mockFileManager.saveJsonFile(
        '${mockDirectory.path}/${config.projectId}',
        'config.json',
        config.toJson(),
      )).called(1);
    });
  });
}
