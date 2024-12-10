import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';

class UploadService {
  final VideoManager videoManager;
  final FileManager fileManager;

  UploadService({
    required this.videoManager,
    required this.fileManager,
  });

  Future<void> moveFile(VideoDataModel file) async {
    await file.xfile.saveTo(file.path);
  }
}
