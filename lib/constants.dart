import 'package:com_nicodevelop_xmagicmovie/components/list_projet/list_projet_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/upload_file_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/video_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

/// Gestion des fichiers
const String kWorkDir = 'XMagicMovieWorkspace';

/// Gestion des vues
const String kUploadView = 'UploadView';
const String kCropSelectorView = 'CropSelectorView';

const String kDefaultView = kUploadView;

/// Gestion des outils
const String kPlayerTool = 'PlayerTool';
const String kCropTool = 'CropTool';

/// Gestion du style
const double kDefaultPadding = 8.0;

/// Modal
const int kDefaultCloseDuration = 5;

Map<String, Widget> kListView = {
  kUploadView: const SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(
        kDefaultPadding * 3,
      ),
      child: Wrap(
        runSpacing: kDefaultPadding * 3,
        children: [
          UploadFileComponent(),
          ListProjectComponent(),
        ],
      ),
    ),
  ),
  kCropSelectorView: BlocBuilder<VideoBloc, VideoState>(
    builder: (context, state) {
      if (!state.isInitialized || state.controller == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final VideoPlayerController controller = state.controller!;
      final double aspectRatio = controller.value.aspectRatio;
      final bool isPlaying = state.isPlaying;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoComponent(
                controller: controller,
                aspectRatio: aspectRatio,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<VideoBloc>().add(
                          !isPlaying
                              ? const OnPlayEvent()
                              : const OnPauseEvent(),
                        );
                  },
                  icon: Icon(
                    !isPlaying ? Icons.play_arrow_rounded : Icons.pause_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  ),
};
