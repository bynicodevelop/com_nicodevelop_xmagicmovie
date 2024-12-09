import 'package:com_nicodevelop_xmagicmovie/components/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonProjectComponent extends StatelessWidget {
  final ConfigModel config;

  const ButtonProjectComponent({
    required this.config,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
        listener: (context, state) {
          context.read<VideoBloc>().add(
                InitializeVideo(
                  state.videoFile,
                ),
              );

          context.read<ToolBloc>().add(
                OnPlayerToolEvent(),
              );

          context.read<ViewManagerBloc>().add(
                const ViewManagerEvent(
                  kCropSelectorView,
                ),
              );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              context.read<ProjectBloc>().add(
                    LoadProject(
                      config,
                    ),
                  );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.movie_rounded,
                size: 50,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ));
  }
}
