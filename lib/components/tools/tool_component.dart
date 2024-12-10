import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/button_run_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolComponent extends StatelessWidget {
  const ToolComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunBloc, RunState>(
      builder: (context, state) {
        final bool isLoading = state is RunInProgress;

        return BlocBuilder<ToolBloc, ToolState>(builder: (context, state) {
          final bool isDisabled = state is ToolReset || isLoading;
          final bool hasActiveTool = state.canRun;

          return Padding(
            padding: const EdgeInsets.only(
              right: 22,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.crop,
                    color: isDisabled
                        ? Colors.grey.shade600
                        : state.isCropTool
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: isDisabled
                      ? null
                      : () => context.read<ToolBloc>().add(
                            OnCropToolEvent(),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                  ),
                  child: ButtonRunComponent(
                    hasActiveTool: hasActiveTool,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
