import 'package:com_nicodevelop_xmagicmovie/components/tools/tool_component.dart';
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

Map<String, Widget> kListView = {
  kUploadView: Scaffold(
    appBar: AppBar(
      actions: const [
        ToolComponent(),
      ],
    ),
    body: BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (!state.isInitialized || state.controller == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final VideoPlayerController controller = state.controller!;
        final double aspectRatio = controller.value.aspectRatio;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VideoComponent(
              controller: controller,
              aspectRatio: aspectRatio,
            ),
          ],
        );
      },
    ),
  ),
  kCropSelectorView: Scaffold(
    body: BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (!state.isInitialized || state.controller == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth > 0 ? constraints.maxWidth : 300;
            final double aspectRatio = state.controller!.value.aspectRatio;

            // return AspectRatio(
            //   aspectRatio: aspectRatio,
            //   child: CropSelectorComponent(
            //     child: (context) => const Text(""),
            //   ),
            // );

            return const Text("");
          },
        );
      },
    ),
  ),
};
