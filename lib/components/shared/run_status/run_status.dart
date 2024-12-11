import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RunStatus extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    bool isLoading,
  ) builder;

  const RunStatus({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunBloc, RunState>(
      builder: (context, state) {
        final bool isLoading =
            state is RunInProgressState || state is RunProgressUpdate;

        return builder(
          context,
          isLoading,
        );
      },
    );
  }
}
