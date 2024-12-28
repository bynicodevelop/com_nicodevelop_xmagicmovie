import 'package:com_nicodevelop_xmagicmovie/constants.dart';
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
      padding: const EdgeInsets.all(
        kDefaultPadding,
      ),
      child: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(
          kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Chip(
                  label: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: kDefaultPadding * 1.5,
                          ),
                      children: [
                        TextSpan(text: sentence.startTime.toStringAsFixed(2)),
                        const TextSpan(text: ' - '),
                        TextSpan(text: sentence.endTime.toStringAsFixed(2)),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 4,
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 4,
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      kDefaultPadding * 2,
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: kDefaultPadding,
              children: sentence.words.map((wordModel) {
                return EditableWordWidget(
                  wordModel: wordModel,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
