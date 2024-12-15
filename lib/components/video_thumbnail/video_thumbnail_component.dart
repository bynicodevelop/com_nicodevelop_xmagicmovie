import 'dart:typed_data';

import 'package:com_nicodevelop_xmagicmovie/components/video_thumbnail/bloc/video_thumbnail_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoThumbnailComponent extends StatefulWidget {
  final ConfigModel config;

  const VideoThumbnailComponent({
    required this.config,
    super.key,
  });

  @override
  State<VideoThumbnailComponent> createState() =>
      _VideoThumbnailComponentState();
}

class _VideoThumbnailComponentState extends State<VideoThumbnailComponent> {
  late VideoThumbnailBloc _localVideoThumbnailBloc;

  @override
  void initState() {
    super.initState();

    final videoManager = context.read<VideoManager>();
    _localVideoThumbnailBloc = VideoThumbnailBloc(
      videoManager: videoManager,
    )..add(OnLoadVideoThumbnail(
        config: widget.config,
      ));
  }

  @override
  void dispose() {
    _localVideoThumbnailBloc.close();
    super.dispose();
  }

  Image _buildImage(Uint8List thumbnail) {
    return Image.memory(
      thumbnail,
      key: const ValueKey(
        'loadedImage',
      ),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Skeletonizer _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        duration: const Duration(seconds: 2),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _localVideoThumbnailBloc,
      child: BlocBuilder<VideoThumbnailBloc, VideoThumbnailState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(
              seconds: 1,
            ),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: state is VideoThumbnailLoaded
                ? _buildImage(state.thumbnail)
                : _buildSkeleton(),
          );
        },
      ),
    );
  }
}
