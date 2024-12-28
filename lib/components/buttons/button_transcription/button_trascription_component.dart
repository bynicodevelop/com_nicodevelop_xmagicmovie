import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_transcription/bloc/transcription_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/notification/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonTrascriptionComponent extends StatefulWidget {
  final bool readOnly;

  const ButtonTrascriptionComponent({
    this.readOnly = false,
    super.key,
  });

  @override
  State<ButtonTrascriptionComponent> createState() =>
      _ButtonTrascriptionComponentState();
}

class _ButtonTrascriptionComponentState
    extends State<ButtonTrascriptionComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialiser le contrôleur d'animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialiser le ColorTween ici, car Theme.of(context) est maintenant accessible
    _colorAnimation = ColorTween(
      begin: Colors.grey.shade400,
      end: Theme.of(context).primaryColor,
    ).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  VideoDataModel _getVideoDataModel(
    BuildContext context,
  ) {
    final UploadState uplaodState = context.read<UploadBloc>().state;
    final VideoDataModel projectState =
        context.read<ProjectBloc>().state.videoDataModel;

    return uplaodState.files.isNotEmpty
        ? uplaodState.files.first
        : projectState;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TranscriptionBloc>().state;

    if (state is TranscriptionLoading) {
      _animationController.forward();
    } else {
      _animationController.stop();
    }

    return BlocListener<TranscriptionBloc, TranscriptionState>(
      listener: (context, state) {
        if (state is TranscriptionSuccess) {
          context.read<ModalBloc>().add(
                const OnOpenModal(
                  title: 'Transcription réussie 💪',
                  message: 'La transcription a été effectuée avec succès.',
                ),
              );
        }

        if (state is TranscriptionAlreadyTranscribed) {
          context.read<ViewManagerBloc>().add(
                const ViewManagerEvent(
                  kTranscriptionView,
                ),
              );
        }
      },
      child: IconButton(
        icon: state is TranscriptionLoading
            ? AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Icon(
                    Icons.multitrack_audio_outlined,
                    color: _colorAnimation.value,
                  );
                },
              )
            : const Icon(
                Icons.multitrack_audio_outlined,
              ),
        onPressed: widget.readOnly || state is TranscriptionLoading
            ? null
            : () {
                final VideoDataModel videoDataModel =
                    _getVideoDataModel(context);

                context.read<TranscriptionBloc>().add(
                      OnTranscriptionEvent(
                        videoDataModel: videoDataModel,
                      ),
                    );
              },
      ),
    );
  }
}
