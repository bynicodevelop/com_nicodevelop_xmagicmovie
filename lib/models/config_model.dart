import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class ConfigModel extends Model {
  final String projectId;
  final String? sourceFileName;

  ConfigModel({
    required this.projectId,
    this.sourceFileName,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        projectId: json['projectId'],
        sourceFileName: json['sourceFileName'] ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'sourceFileName': sourceFileName,
      };
}
