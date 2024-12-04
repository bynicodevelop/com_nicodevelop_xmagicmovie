import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolComponent extends StatelessWidget {
  const ToolComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolBloc, ToolState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 22,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.crop,
                color: context.read<ToolBloc>().state.isCropTool
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => context.read<ToolBloc>().add(
                    OnCropToolEvent(),
                  ),
            ),
          ],
        ),
      );
    });
  }
}
