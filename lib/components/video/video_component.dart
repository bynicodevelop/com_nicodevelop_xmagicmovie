import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/crop_selector_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/zoom/bloc/zoom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class _ConstraintsData {
  final double maxWidth;
  final double maxHeight;

  _ConstraintsData(
    this.maxWidth,
    this.maxHeight,
  );
}

class VideoComponent extends StatefulWidget {
  final VideoPlayerController controller;
  final double aspectRatio;
  final bool readOnly;

  const VideoComponent({
    required this.controller,
    required this.aspectRatio,
    this.readOnly = false,
    super.key,
  });

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyZoom(0));
  }

  void _applyZoom(double zoomValue) {
    // Convertit la valeur du slider (-100 à 100) en un facteur d'échelle (0.5 à 4.0)
    double scale = 1 + (zoomValue / 100) * 1.5;
    scale =
        scale.clamp(0.5, 4.0); // S'assure que le scale reste entre 0.5 et 4.0

    // Calcule le décalage pour centrer la vidéo après le zoom
    final size = context.size;
    if (size != null) {
      final offsetX = (size.width - (size.width * scale)) / 2;
      final offsetY = (size.height - (size.height * scale)) / 2;

      // Applique la transformation combinée de zoom et de translation
      _transformationController.value = Matrix4.identity()
        ..translate(offsetX, offsetY)
        ..scale(scale);
    }
  }

  double _getConstraintHeight(
    BuildContext context,
    double videoHeight, {
    double heightProportion = 0.5,
  }) {
    final maxAllowedHeight =
        MediaQuery.of(context).size.height * heightProportion;
    return videoHeight > maxAllowedHeight ? maxAllowedHeight : videoHeight;
  }

  _ConstraintsData _getConstraintsData(
    BuildContext context,
    double width,
  ) {
    double initialMaxWidth = width > 0 ? width : 300;
    final double maxHeight = _getConstraintHeight(
      context,
      initialMaxWidth / widget.controller.value.aspectRatio,
    );
    final double maxWidth = maxHeight * widget.controller.value.aspectRatio;

    return _ConstraintsData(
      maxWidth,
      maxHeight,
    );
  }

  Widget _buildVideoPlayer() {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 4.0,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: VideoPlayer(widget.controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocListener<ZoomBloc, ZoomState>(
          listener: (context, state) {
            if (state is ZoomInitialState) {
              _applyZoom(state.value);
            }
          },
          child: BlocBuilder<ToolBloc, ToolState>(
            builder: (context, toolState) {
              return BlocBuilder<VideoBloc, VideoState>(
                builder: (context, videoState) {
                  final constraintsData = _getConstraintsData(
                    context,
                    constraints.maxWidth,
                  );

                  context.read<VideoBloc>().add(
                        UpdateConstraintsEvent(
                          constraintsData.maxWidth,
                          constraintsData.maxHeight,
                        ),
                      );

                  if (toolState.isCropTool) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraintsData.maxWidth,
                        maxHeight: constraintsData.maxHeight,
                      ),
                      child: CropSelectorComponent(
                        maxWidth: videoState.maxWidth,
                        maxHeight: videoState.maxHeight,
                        child: (context) => _buildVideoPlayer(),
                        readOnly: widget.readOnly,
                      ),
                    );
                  }

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraintsData.maxWidth,
                      maxHeight: constraintsData.maxHeight,
                    ),
                    child: _buildVideoPlayer(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
