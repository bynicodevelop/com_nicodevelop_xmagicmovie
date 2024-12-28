import 'package:com_nicodevelop_xmagicmovie/models/transcription/sentence_model.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/editable_word_widget.dart';
import 'package:flutter/material.dart';

class SentenceItemWidget extends StatelessWidget {
  final SentenceModel sentence;

  const SentenceItemWidget({
    required this.sentence,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: sentence.words.map((wordModel) {
          return EditableWordWidget(
            wordModel: wordModel,
          );
        }).toList(),
      ),
    );
  }
}
