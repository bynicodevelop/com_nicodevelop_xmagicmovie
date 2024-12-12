import 'package:flutter/material.dart';

class ResizeButtonWidget extends StatelessWidget {
  final Function(DragUpdateDetails details) onPanUpdate;
  final Function()? onExit;
  final IconData icon;
  final bool readOnly;

  const ResizeButtonWidget({
    super.key,
    required this.onPanUpdate,
    required this.icon,
    this.readOnly = false,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (event) => onExit?.call(),
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        onPanUpdate: !readOnly ? onPanUpdate : null,
        onPanEnd: !readOnly ? (details) => onExit?.call() : null,
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: !readOnly ? Colors.white : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
