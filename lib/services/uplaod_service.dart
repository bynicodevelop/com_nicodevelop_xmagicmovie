import 'package:com_nicodevelop_xmagicmovie/models/file_model.dart';

class UplaodService {
  Future<void> moveFile(
    FileModel file,
  ) async =>
      file.xfile.saveTo(file.path);
}
