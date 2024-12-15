import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/button_delete_project_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/shared/hover/hover.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video_thumbnail/video_thumbnail_component.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonProjectComponent extends StatefulWidget {
  final ConfigModel config;

  const ButtonProjectComponent({
    required this.config,
    super.key,
  });

  @override
  State<ButtonProjectComponent> createState() => _ButtonProjectComponentState();
}

class _ButtonProjectComponentState extends State<ButtonProjectComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        context.read<VideoBloc>().add(
              InitializeVideo(
                state.videoDataModel,
              ),
            );

        context.read<ToolBloc>().add(
              OnInitializeToolEvent(),
            );
      },
      child: Hover(
        builder: (context, isHover) => Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              context.read<ProjectBloc>().add(
                    LoadProject(
                      widget.config,
                    ),
                  );
            },
            child: Hover(
              builder: (context, isHover) {
                return Stack(
                  children: [
                    VideoThumbnailComponent(
                      config: widget.config,
                    ),
                    if (isHover)
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.grey.shade300.withAlpha((0.5 * 255).toInt()),
                      ),
                    if (isHover)
                      Positioned(
                        top: kDefaultPadding,
                        right: kDefaultPadding,
                        child: ButtonDeleteProjectComponent(
                          callback: () =>
                              context.read<ProjectDeletionBloc>().add(
                                    OnDeleteProject(
                                      widget.config.projectId,
                                    ),
                                  ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
