import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';
import 'package:flutter/material.dart';

class EditableWordWidget extends StatefulWidget {
  final WordModel wordModel;

  const EditableWordWidget({
    required this.wordModel,
    super.key,
  });

  @override
  State<EditableWordWidget> createState() => _EditableWordWidgetState();
}

class _EditableWordWidgetState extends State<EditableWordWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.wordModel.word);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isHovering = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovering || _focusNode.hasFocus
                ? Colors.grey
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            kDefaultPadding / 2,
          ),
        ),
        child: IntrinsicWidth(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              fontSize: kDefaultPadding * 1.8,
            ),
            onSubmitted: (newValue) {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
