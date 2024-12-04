import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_event.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_state.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/update_constraints_event.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/aspect_ratio_button_widget.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/resize_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CropSelectorComponent extends StatefulWidget {
  final Widget Function(BuildContext) child;
  final double maxWidth;
  final double maxHeight;

  const CropSelectorComponent({
    required this.child,
    required this.maxWidth,
    required this.maxHeight,
    super.key,
  });

  @override
  State<CropSelectorComponent> createState() => _CropSelectorComponentState();
}

class _CropSelectorComponentState extends State<CropSelectorComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CropSelectorBloc, CropSelectorState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          final adjustedMaxWidth = widget.maxWidth > constraints.maxWidth
              ? constraints.maxWidth
              : widget.maxWidth;
          final adjustedMaxHeight = widget.maxHeight > constraints.maxHeight
              ? constraints.maxHeight
              : widget.maxHeight;

          context.read<CropSelectorBloc>().add(
                UpdateConstraintsEvent(
                  adjustedMaxWidth,
                  adjustedMaxHeight,
                ),
              );

          return Stack(
            children: [
              Container(
                color: Colors.black,
                child: Builder(
                  builder: widget.child,
                ),
              ),
              Positioned(
                left: state.cropX,
                top: state.cropY,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    context.read<CropSelectorBloc>().add(
                          UpdateCropPosition(
                            details.delta.dx,
                            details.delta.dy,
                          ),
                        );
                  },
                  child: Container(
                    width: state.cropWidth,
                    height: state.cropHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      color: Colors.red.withOpacity(0.3),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AspectRationButtonWidget(
                                icon: Icons.photo_size_select_small_outlined,
                                aspectRatio: 0,
                                state: state,
                                onPressed: state.lockedAspectRatio != 0
                                    ? () {
                                        context
                                            .read<CropSelectorBloc>()
                                            .add(const SetAspectRatio(0));
                                      }
                                    : null,
                              ),
                              AspectRationButtonWidget(
                                icon: Icons.crop_portrait,
                                aspectRatio: 9 / 16,
                                state: state,
                                onPressed: state.lockedAspectRatio != 9 / 16
                                    ? () {
                                        context
                                            .read<CropSelectorBloc>()
                                            .add(const SetAspectRatio(9 / 16));
                                      }
                                    : null,
                              ),
                              AspectRationButtonWidget(
                                icon: Icons.crop_landscape,
                                aspectRatio: 16 / 9,
                                state: state,
                                onPressed: state.lockedAspectRatio != 16 / 9
                                    ? () {
                                        context
                                            .read<CropSelectorBloc>()
                                            .add(const SetAspectRatio(16 / 9));
                                      }
                                    : null,
                              ),
                              AspectRationButtonWidget(
                                icon: Icons.crop_square,
                                aspectRatio: 1,
                                state: state,
                                onPressed: state.lockedAspectRatio != 1
                                    ? () {
                                        context
                                            .read<CropSelectorBloc>()
                                            .add(const SetAspectRatio(1));
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: ResizeButtonWidget(
                            onPanUpdate: (details) {
                              context.read<CropSelectorBloc>().add(
                                    ResizeCropArea(
                                      details.delta.dx,
                                      details.delta.dy,
                                      adjustX: true,
                                      adjustY: true,
                                    ),
                                  );
                            },
                            icon: Icons.north_west,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: ResizeButtonWidget(
                            onPanUpdate: (details) {
                              context.read<CropSelectorBloc>().add(
                                    ResizeCropArea(
                                      details.delta.dx,
                                      details.delta.dy,
                                      adjustX: false,
                                      adjustY: true,
                                    ),
                                  );
                            },
                            icon: Icons.north_east,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: ResizeButtonWidget(
                            onPanUpdate: (details) {
                              context.read<CropSelectorBloc>().add(
                                    ResizeCropArea(
                                      details.delta.dx,
                                      details.delta.dy,
                                      adjustX: true,
                                      adjustY: false,
                                    ),
                                  );
                            },
                            icon: Icons.south_west,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ResizeButtonWidget(
                            onPanUpdate: (details) {
                              context.read<CropSelectorBloc>().add(
                                    ResizeCropArea(
                                      details.delta.dx,
                                      details.delta.dy,
                                      adjustX: false,
                                      adjustY: false,
                                    ),
                                  );
                            },
                            icon: Icons.south_east,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
