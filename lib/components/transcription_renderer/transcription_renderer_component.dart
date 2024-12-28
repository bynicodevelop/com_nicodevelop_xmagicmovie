import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/transcription.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/sentence_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranscriptionRendererComponent extends StatelessWidget {
  final Transcription _transcription = Transcription();

  TranscriptionRendererComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 20,
          child: IconButton(
            onPressed: () => context.read<ViewManagerBloc>().add(
                  const ViewManagerEvent(
                    kCropSelectorView,
                  ),
                ),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ),
        SingleChildScrollView(
          child: BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              final sentences = _transcription
                  .createSentences(state.videoData!.transcription!);

              return ListView.builder(
                shrinkWrap: true,
                itemCount: sentences.length,
                itemBuilder: (context, index) {
                  final sentence = sentences[index];

                  return SentenceItemWidget(
                    sentence: sentence,
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
