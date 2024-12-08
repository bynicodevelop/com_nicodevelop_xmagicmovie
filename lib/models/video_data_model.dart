import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class VideoDataModel extends Model {
  final String projectId;
  final String name;
  final String path;
  final String uniqueFileName;
  final XFile xfile;
  final SizeModel size;

  VideoDataModel({
    required this.projectId,
    required this.name,
    required this.path,
    required this.uniqueFileName,
    required this.xfile,
    required this.size,
  });

  @override
  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'name': name,
        'path': path,
        'uniqueFileName': uniqueFileName,
        'size': size.toJson(),
      };
}
