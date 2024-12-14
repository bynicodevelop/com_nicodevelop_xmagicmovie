import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/widgets/buttons/button_crop_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_open_file/button_open_file_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/button_run_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/shared/run_status/run_status.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolComponent extends StatelessWidget {
  const ToolComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return RunStatus(builder: (context, isLoading) {
      return BlocBuilder<ToolBloc, ToolState>(
        builder: (context, state) {
          final bool isDisabled = state is ToolReset || isLoading;
          final bool canRun = state.canRun;

          return Padding(
            padding: const EdgeInsets.only(
              right: 22,
            ),
            child: Row(
              children: [
                ButtonOpenFileComponent(
                  onPressed: (String link) => Process.run('open', [link]),
                ),
                ButtonCropComponent(
                  readOnly: isDisabled,
                  active: state.isCropTool,
                  onPressed: () =>
                      context.read<ToolBloc>().add(OnCropToolEvent()),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                  ),
                  child: ButtonRunComponent(
                    readOnly: !canRun || isLoading,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
