import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_service_test.mocks.dart';

@GenerateMocks([VideoManager, FileManager])
void main() {
  late UploadService uploadService;
  late MockVideoManager mockVideoManager;
  late MockFileManager mockFileManager;
  late File tempFile;

  setUp(() async {
    mockVideoManager = MockVideoManager();
    mockFileManager = MockFileManager();
    uploadService = UploadService(
      videoManager: mockVideoManager,
      fileManager: mockFileManager,
    );

    // Créer un fichier temporaire pour le test
    tempFile = await File('${Directory.systemTemp.path}/test.mp4').create();
    await tempFile.writeAsString('Temporary file content');
  });

  tearDown(() async {
    // Nettoyer le fichier temporaire après le test
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  });

  test('processFile should process file and return VideoDataModel', () async {
    // Arrange
    final XFile testFile = XFile(tempFile.path);
    final SizeModel testSize = SizeModel(1920, 1080);
    final Directory testWorkingDir =
        Directory('${Directory.systemTemp.path}/test_dir');
    final Map<String, String> uniqueFileName = {
      'hash': '12345abc',
      'fileName': '12345abc.mp4'
    };

    when(mockFileManager.getWorkingDirectory())
        .thenAnswer((_) async => testWorkingDir);
    when(mockFileManager.generateUniqueFileName(testFile))
        .thenAnswer((_) async => uniqueFileName);
    when(mockVideoManager.getVideoSize(testFile))
        .thenAnswer((_) async => testSize);

    // Act
    final result = await uploadService.processFile(testFile);

    // Assert
    expect(result.projectId, '12345abc');
    expect(result.name, 'test.mp4');
    expect(result.path, '${testWorkingDir.path}/12345abc/12345abc.mp4');
    expect(result.uniqueFileName, '12345abc.mp4');
    expect(result.size, testSize);

    verify(mockFileManager.getWorkingDirectory()).called(1);
    verify(mockFileManager.generateUniqueFileName(testFile)).called(1);
    verify(mockVideoManager.getVideoSize(testFile)).called(1);
    expect(await File(result.path).exists(), isTrue);
  });
}
