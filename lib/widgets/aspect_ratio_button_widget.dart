import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_state.dart';
import 'package:flutter/material.dart';

class AspectRationButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final double aspectRatio;
  final CropSelectorState state;

  const AspectRationButtonWidget({
    super.key,
    this.onPressed,
    required this.icon,
    required this.aspectRatio,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: state.lockedAspectRatio != aspectRatio
            ? Colors.white
            : Colors.white.withOpacity(0.5),
      ),
    );
  }
}
