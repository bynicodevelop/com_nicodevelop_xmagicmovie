import 'package:flutter/material.dart';

class ResizeButtonWidget extends StatelessWidget {
  final Function(DragUpdateDetails details) onPanUpdate;
  final IconData icon;

  const ResizeButtonWidget({
    super.key,
    required this.onPanUpdate,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
