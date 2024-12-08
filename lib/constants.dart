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

/// Gestion du style
const double kDefaultPadding = 8.0;

/// Modal
const int kDefaultCloseDuration = 5;

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
};
