import 'package:cross_file/cross_file.dart';
import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class FileModel extends Model {
  final String name;
  final String path;
  final String uniqueFileName;
  final XFile xfile;

  FileModel({
    required this.name,
    required this.path,
    required this.uniqueFileName,
    required this.xfile,
  });

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'path': path,
        'uniqueFileName': uniqueFileName,
      };
}
