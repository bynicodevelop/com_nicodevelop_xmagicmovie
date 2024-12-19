import 'package:crop/crop.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StageZoneComponent extends StatefulWidget {
  final VideoPlayerController controller;

  const StageZoneComponent({
    required this.controller,
    super.key,
  });

  @override
  State<StageZoneComponent> createState() => _StageZoneComponentState();
}

class _StageZoneComponentState extends State<StageZoneComponent> {
  final ValueNotifier<double> _ratio = ValueNotifier<double>(16 / 9);
  final ValueNotifier<double> _scale = ValueNotifier<double>(1.0);
  final ValueNotifier<Offset> _offset = ValueNotifier<Offset>(Offset.zero);

  late CropController _cropController;

  double _getConstraintHeight(BuildContext context, double videoHeight,
      {double heightProportion = 0.5}) {
    final maxAllowedHeight =
        MediaQuery.of(context).size.height * heightProportion;
    return videoHeight > maxAllowedHeight ? maxAllowedHeight : videoHeight;
  }

  @override
  void initState() {
    super.initState();
    _cropController = CropController(
      aspectRatio: _ratio.value,
      scale: _scale.value,
    );
    _ratio.addListener(() => _cropController.aspectRatio = _ratio.value);
    _scale.addListener(() {
      double adjustedScale = 1.0 + _scale.value / 100;
      _cropController.scale = adjustedScale.clamp(0.5, 5.0);
    });
    _offset.addListener(() {
      print(_offset.value.dx);
      _cropController.offset = Offset(_offset.value.dx, 0);
    });
  }

  @override
  void dispose() {
    _ratio.dispose();
    _scale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double initialMaxWidth =
          constraints.maxWidth > 0 ? constraints.maxWidth : 300;
      final double maxHeight = _getConstraintHeight(
          context, initialMaxWidth / widget.controller.value.aspectRatio);
      final double maxWidth = maxHeight * widget.controller.value.aspectRatio;

      return Stack(
        children: [
          SizedBox(
            width: maxWidth,
            height: maxHeight,
            child: Crop(
              controller: _cropController,
              shape: BoxShape.rectangle,
              onChanged: (value) {
                _offset.value = value.translation;
              },
              child: SizedBox(
                width: maxWidth,
                height: maxHeight,
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _ratio.value = 16 / 9;
                    _scale.value = 0.0;
                    _offset.value = Offset.zero;
                    _cropController.offset = _offset.value;
                  });
                },
                icon: const Icon(Icons.crop_landscape_outlined),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _ratio.value = 9 / 16;
                    _scale.value = 0.0;
                    _offset.value = Offset.zero;
                    _cropController.offset = _offset.value;
                  });
                },
                icon: const Icon(Icons.crop_portrait_outlined),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _ratio.value = 1.0;
                    _scale.value = 0.0;
                    _offset.value = Offset.zero;
                    _cropController.offset = _offset.value;
                  });
                },
                icon: const Icon(Icons.crop_square_outlined),
              ),
              Slider(
                value: _scale.value,
                min: -100,
                max: 100,
                divisions: 200,
                label: _scale.value.toStringAsFixed(0),
                onChanged: (double newValue) {
                  setState(() => _scale.value = newValue);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
