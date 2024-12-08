import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class ConfigModel extends Model {
  final String projectId;

  ConfigModel({
    required this.projectId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'projectId': projectId,
      };
}
