import 'package:flutter/material.dart';

class ButtonCropComponent extends StatelessWidget {
  final bool readOnly;
  final bool active;
  final void Function()? onPressed;

  const ButtonCropComponent(
      {this.readOnly = false, this.active = false, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.crop,
        color: readOnly
            ? Colors.grey.shade600
            : active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: readOnly ? null : onPressed,
    );
  }
}
