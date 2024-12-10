import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/button_delete_project_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
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
  bool _isHovered = false;

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
              OnInitializeToolEvent(),
            );
      },
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = !_isHovered),
        onExit: (event) => setState(() => _isHovered = !_isHovered),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              context.read<ProjectBloc>().add(
                    LoadProject(
                      widget.config,
                    ),
                  );
            },
            child: Stack(
              children: [
                if (_isHovered)
                  Positioned(
                    top: kDefaultPadding,
                    right: kDefaultPadding,
                    child: ButtonDeleteProjectComponent(
                      callback: () => context.read<ProjectDeletionBloc>().add(
                            OnDeleteProject(
                              widget.config.projectId,
                            ),
                          ),
                    ),
                  ),
                Center(
                  child: Icon(
                    Icons.movie_rounded,
                    size: 50,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
