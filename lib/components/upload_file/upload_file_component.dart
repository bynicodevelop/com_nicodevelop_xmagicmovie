import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFileComponent extends StatefulWidget {
  const UploadFileComponent({super.key});

  @override
  State<UploadFileComponent> createState() => _UploadFileComponentState();
}

class _UploadFileComponentState extends State<UploadFileComponent> {
  static const List<String> _allowedExtensions = ['mp4', 'mov'];
  bool _isHovering = false;
  String? _errorMessage;

  void _uploadFile(List<XFile> files) {
    setState(() => _errorMessage = null);

    if (_extentionNotSupported(files)) {
      setState(
        () => _errorMessage =
            "Les fichiers doivent être de type ${_allowedExtensions.join(', ')}",
      );
      return;
    }

    context.read<UploadBloc>().add(
          UploadFileEvent(files),
        );
  }

  bool _extentionNotSupported(List<XFile> files) {
    for (var file in files) {
      final extention = file.path.split('.').last.toLowerCase();
      if (!_allowedExtensions.contains(extention)) {
        return true;
      }
    }

    return false;
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
    );

    if (result != null && result.files.isNotEmpty) {
      final files = result.files.map((file) => XFile(file.path!)).toList();
      _uploadFile(files);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        return DropTarget(
          onDragEntered: (event) => setState(() => _isHovering = true),
          onDragExited: (details) => setState(() => _isHovering = false),
          onDragDone: (details) {
            _uploadFile(details.files);
            setState(() => _isHovering = false);
          },
          child: DottedBorder(
            color: _isHovering ? Colors.blue.shade900 : Colors.grey.shade300,
            strokeWidth: 2,
            dashPattern: const [5, 5],
            radius: const Radius.circular(12),
            borderType: BorderType.RRect,
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Déposer votre fichier vidéo ici"),
                  TextButton(
                    onPressed: _pickFiles,
                    child: const Text(
                      "Ou cliquez pour sélectionner un fichier",
                    ),
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
