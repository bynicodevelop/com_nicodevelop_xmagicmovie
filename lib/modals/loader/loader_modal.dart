import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/loader/bloc/loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderModal extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  const LoaderModal({
    required this.builder,
    super.key,
  });

  @override
  State<LoaderModal> createState() => _LoaderModalState();
}

class _LoaderModalState extends State<LoaderModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<UploadBloc, UploadState>(
            listener: (context, state) {
              if (state is UploadInProgress) {
                context.read<LoaderBloc>().add(LoaderInProgressEvent());
              }
            },
          ),
          BlocListener<ProjectBloc, ProjectState>(
            listener: (context, state) {
              if (state.videoDataModel.projectId.isNotEmpty) {
                context.read<LoaderBloc>().add(LoaderInProgressEvent());
              }
            },
          ),
          BlocListener<ToolBloc, ToolState>(
            listener: (context, state) {
              if (state is ToolInitialized) {
                context.read<LoaderBloc>().add(LoaderIdleEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<LoaderBloc, LoaderState>(
          builder: (context, state) {
            return Stack(
              children: [
                widget.builder(context),
                if (state is LoaderInProgressState)
                  Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Center(
                      child: SpinKitSpinningLines(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50.0,
                        controller: _controller,
                      ),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}
