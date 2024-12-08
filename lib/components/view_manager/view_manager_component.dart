import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
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
  void initState() {
    super.initState();

    FileManager.getFilePath('f9186b9df6a1d0305b0d05610a8f53ef.mp4')
        .then((path) {
      context.read<UploadBloc>().add(UploadFileEvent([XFile(path)]));
      context.read<VideoBloc>().add(InitializeVideo(XFile(path)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
            if (state.files.isNotEmpty) {
              context.read<ViewManagerBloc>().add(
                    const ViewManagerEvent(
                      kCropSelectorView,
                    ),
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
