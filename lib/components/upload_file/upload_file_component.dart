import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFileComponent extends StatefulWidget {
  const UploadFileComponent({super.key});

  @override
  State<UploadFileComponent> createState() => _UploadFileComponentState();
}

class _UploadFileComponentState extends State<UploadFileComponent> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(builder: (context, state) {
      return DropTarget(
        onDragEntered: (event) => setState(() => _isHovering = true),
        onDragExited: (details) => setState(() => _isHovering = false),
        onDragDone: (details) {
          context.read<UploadBloc>().add(
                UploadFileEvent(details.files),
              );

          setState(() => _isHovering = false);
        },
        child: DottedBorder(
          color: _isHovering ? Colors.blue.shade900 : Colors.grey.shade300,
          strokeWidth: 2,
          dashPattern: const [5, 5],
          radius: const Radius.circular(12),
          borderType: BorderType.RRect,
          child: const SizedBox(
            height: 200,
            child: Center(
              child: Text("Drag and drop files here"),
            ),
          ),
        ),
      );
    });
  }
}
