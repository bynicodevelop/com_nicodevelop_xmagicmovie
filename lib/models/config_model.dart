import 'package:com_nicodevelop_xmagicmovie/models/model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';

class ConfigModel extends Model {
  final String projectId;
  final String? sourceFileName;
  final TranscriptionModel? transcription;

  ConfigModel({
    required this.projectId,
    this.sourceFileName,
    this.transcription,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        projectId: json['projectId'],
        sourceFileName: json['sourceFileName'] ?? '',
        transcription: json['transcription'] != null
            ? TranscriptionModel.fromJson(json['transcription'])
            : null,
      );

  // copyWith method
  ConfigModel copyWith({
    String? projectId,
    String? sourceFileName,
    TranscriptionModel? transcription,
  }) {
    return ConfigModel(
      projectId: projectId ?? this.projectId,
      sourceFileName: sourceFileName ?? this.sourceFileName,
      transcription: transcription ?? this.transcription,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'sourceFileName': sourceFileName,
        'transcription': transcription?.toJson(),
      };
}
