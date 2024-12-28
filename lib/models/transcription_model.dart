import 'package:com_nicodevelop_xmagicmovie/models/model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';

class TranscriptionModel extends Model {
  final String text;
  final List<WordModel> words;
  final double? duration;
  final String? language;

  TranscriptionModel({
    required this.text,
    required this.words,
    required this.duration,
    required this.language,
  });

  factory TranscriptionModel.fromJson(Map<String, dynamic> json) =>
      TranscriptionModel(
        text: json['text'],
        words:
            (json['words'] as List).map((e) => WordModel.fromJson(e)).toList(),
        duration: json['duration'],
        language: json['language'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "text": text,
        "words": words.map((e) => e.toJson()).toList(),
        "duration": duration,
        "language": language,
      };
}

class TranscriptionWithGroupedWordsModel extends TranscriptionModel {
  final List<WordModel> groups;

  TranscriptionWithGroupedWordsModel({
    required super.text,
    required super.words,
    required super.duration,
    required super.language,
    required this.groups,
  });
}
