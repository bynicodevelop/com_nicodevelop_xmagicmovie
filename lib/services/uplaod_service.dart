import 'dart:io';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:cross_file/cross_file.dart';

class UploadService {
  final VideoManager videoManager;
  final FileManager fileManager;

  UploadService({
    required this.videoManager,
    required this.fileManager,
  });

  Future<VideoDataModel> processFile(XFile file) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final Map<String, String> uniqueFileName =
        await fileManager.generateUniqueFileName(file);
    final SizeModel size = await videoManager.getVideoSize(file);
    final String projectPath = "${workingDir.path}/${uniqueFileName['hash']}";
    final String filePath = '$projectPath/${uniqueFileName['fileName']}';

    await _createDirectoryIfNotExists(projectPath);
    await file.saveTo(filePath);

    return VideoDataModel(
      projectId: uniqueFileName['hash']!,
      name: file.name,
      path: filePath,
      uniqueFileName: uniqueFileName['fileName']!,
      xfile: file,
      size: size,
    );
  }

  Future<void> moveFile(VideoDataModel file) async {
    await file.xfile.saveTo(file.path);
  }

  Future<void> _createDirectoryIfNotExists(String path) async {
    final Directory directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
}
