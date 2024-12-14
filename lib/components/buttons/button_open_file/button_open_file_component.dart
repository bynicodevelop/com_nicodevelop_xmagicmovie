import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonOpenFileComponent extends StatelessWidget {
  final void Function(String link)? onPressed;

  const ButtonOpenFileComponent({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunBloc, RunState>(
      builder: (context, state) {
        final String path =
            state is RunSuccessState ? File(state.finalPath).parent.path : '';

        return path.isNotEmpty
            ? IconButton(
                onPressed: () => onPressed?.call(
                  path,
                ),
                icon: Icon(
                  Icons.open_in_new_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
