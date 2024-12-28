import 'package:com_nicodevelop_xmagicmovie/models/model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';

class SentenceModel extends Model {
  final List<WordModel> words;

  SentenceModel({
    required this.words,
  });

  double get startTime => words.first.start;

  double get endTime => words.last.end;

  double get duration => endTime - startTime;

  @override
  Map<String, dynamic> toJson() => {
        'words': words.map((word) => word.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentenceModel &&
          runtimeType == other.runtimeType &&
          _listEquals(words, other.words);

  @override
  int get hashCode => words.hashCode;

  bool _listEquals(List<WordModel> list1, List<WordModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
