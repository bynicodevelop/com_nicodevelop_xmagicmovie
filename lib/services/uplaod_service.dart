import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';

class UplaodService {
  Future<void> moveFile(
    VideoDataModel file,
  ) async =>
      file.xfile.saveTo(file.path);
}
