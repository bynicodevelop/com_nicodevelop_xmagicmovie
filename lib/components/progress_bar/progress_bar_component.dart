import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBarComponent extends StatefulWidget {
  const ProgressBarComponent({super.key});

  @override
  State<ProgressBarComponent> createState() => _ProgressBarComponentState();
}

class _ProgressBarComponentState extends State<ProgressBarComponent> {
  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RunBloc, RunState>(
      listener: (context, state) {
        if (state is RunProgressUpdate) {
          setState(() => _progress = state.progress);
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: _progress / 100,
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}
