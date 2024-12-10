import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewManagerComponent extends StatefulWidget {
  const ViewManagerComponent({super.key});

  @override
  State<ViewManagerComponent> createState() => _ViewManagerComponentState();
}

class _ViewManagerComponentState extends State<ViewManagerComponent> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VideoBloc, VideoState>(
          listener: (context, state) {
            if (state is PlayerReset) {
              context.read<ViewManagerBloc>().add(
                    const ViewManagerEvent(
                      kUploadView,
                    ),
                  );

              context.read<ToolBloc>().add(
                    OnResetToolEvent(),
                  );

              context.read<ProjectsBloc>().add(
                    const LoadProjects(),
                  );
              return;
            }

            if (state is PlayerInitial) {
              context.read<ViewManagerBloc>().add(
                    const ViewManagerEvent(
                      kCropSelectorView,
                    ),
                  );

              context.read<ToolBloc>().add(
                    OnInitializeToolEvent(),
                  );
              return;
            }
          },
        ),
        BlocListener<ViewManagerBloc, ViewManagerState>(
          listener: (context, state) {
            if (state.viewName.isNotEmpty) {
              final targetPage =
                  kListView.keys.toList().indexOf(state.viewName);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_pageController.hasClients) {
                  _pageController.jumpToPage(targetPage);
                }
              });
            }
          },
        ),
        BlocListener<UploadBloc, UploadState>(
          listener: (context, state) {
            if (state is UploadSuccess && state.files.isNotEmpty) {
              context.read<VideoBloc>().add(
                    InitializeVideo(
                      VideoDataModel(
                        projectId: '',
                        name: state.files.first.name,
                        path: state.files.first.path,
                        uniqueFileName: '',
                        xfile: XFile(state.files.first.path),
                        size: SizeModel(0, 0),
                      ),
                    ),
                  );

              context.read<ToolBloc>().add(
                    OnInitializeToolEvent(),
                  );
            }
          },
        ),
      ],
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: kListView.values.toList(),
      ),
    );
  }
}
