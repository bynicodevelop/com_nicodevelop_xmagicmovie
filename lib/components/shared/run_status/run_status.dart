import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/notification/bloc/modal_bloc.dart';
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
    return BlocConsumer<RunBloc, RunState>(
      listener: (context, state) {
        if (state is RunFailureState) {
          context.read<ModalBloc>().add(
                const OnOpenModal(
                  title: "Aie ! 😖",
                  message:
                      "Une erreur est survenue lors de l'exécution du programme. Veuillez réessayer.",
                  type: ModalType.error,
                ),
              );
        }
      },
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
