import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/crop_selector_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class _ConstraintsData {
  final double maxWidth;
  final double maxHeight;

  _ConstraintsData(this.maxWidth, this.maxHeight);
}

class VideoComponent extends StatefulWidget {
  final VideoPlayerController controller;
  final double aspectRatio;

  const VideoComponent({
    required this.controller,
    required this.aspectRatio,
    super.key,
  });

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<ToolBloc, ToolState>(
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
                      maxWidth: constraintsData.maxWidth,
                      maxHeight: constraintsData.maxHeight,
                      child: (context) => AspectRatio(
                        aspectRatio: widget.aspectRatio,
                        child: VideoPlayer(widget.controller),
                      ),
                    ),
                  );
                }

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraintsData.maxWidth,
                    maxHeight: constraintsData.maxHeight,
                  ),
                  child: AspectRatio(
                    aspectRatio: widget.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
