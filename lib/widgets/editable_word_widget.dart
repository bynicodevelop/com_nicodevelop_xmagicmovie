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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.wordModel.word);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IntrinsicWidth(
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onSubmitted: (newValue) {
            setState(() {
              // widget.wordModel.word = newValue; // Met à jour le modèle
            });
          },
        ),
      ),
    );
  }
}
