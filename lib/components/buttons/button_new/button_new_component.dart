import 'package:com_nicodevelop_xmagicmovie/components/shared/run_status/run_status.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonNewComponent extends StatelessWidget {
  const ButtonNewComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolBloc, ToolState>(
      builder: (context, state) {
        final bool isDisabled = state is! ToolReset;

        return RunStatus(
          builder: (context, isLoading) {
            return IconButton(
              icon: const Icon(
                Icons.movie_filter_outlined,
              ),
              onPressed: isDisabled && !isLoading
                  ? () {
                      context.read<VideoBloc>().add(
                            const OnResetVideoEvent(),
                          );
                    }
                  : null,
            );
          },
        );
      },
    );
  }
}
