import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_open_file/bloc/open_file_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonOpenFileComponent extends StatefulWidget {
  final void Function(String link)? onPressed;

  const ButtonOpenFileComponent({
    this.onPressed,
    super.key,
  });

  @override
  State<ButtonOpenFileComponent> createState() =>
      _ButtonOpenFileComponentState();
}

class _ButtonOpenFileComponentState extends State<ButtonOpenFileComponent> {
  String _path = '';

  void setPath(
    String path,
  ) =>
      setState(() => _path = path.isNotEmpty ? File(path).parent.path : '');

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RunBloc, RunState>(
          listener: (context, state) {
            if (state is RunSuccessState) {
              setPath(state.finalPath);
            }
          },
        ),
        BlocListener<OpenFileBloc, OpenFileState>(
          listener: (context, state) {
            if (state is OpenFileSuccess) {
              setPath(state.finalPath);
            }
          },
        ),
      ],
      child: _path.isNotEmpty
          ? IconButton(
              onPressed: () => widget.onPressed?.call(
                _path,
              ),
              icon: Icon(
                Icons.open_in_new_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
