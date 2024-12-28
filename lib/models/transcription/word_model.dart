import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class WordModel extends Model {
  final double start;
  final double end;
  final String word;

  WordModel({
    required this.start,
    required this.end,
    required this.word,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        start: json['start'],
        end: json['end'],
        word: json['word'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "word": word,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordModel &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => word.hashCode ^ start.hashCode ^ end.hashCode;
}
