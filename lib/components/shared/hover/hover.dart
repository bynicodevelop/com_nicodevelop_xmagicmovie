import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    bool isHover,
  ) builder;

  const Hover({
    required this.builder,
    super.key,
  });

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHover = true),
      onExit: (event) => setState(() => _isHover = false),
      child: widget.builder(
        context,
        _isHover,
      ),
    );
  }
}
