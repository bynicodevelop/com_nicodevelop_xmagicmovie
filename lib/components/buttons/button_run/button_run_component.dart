import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_state.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonRunComponent extends StatelessWidget {
  final bool hasActiveTool;

  const ButtonRunComponent({
    super.key,
    this.hasActiveTool = false,
  });

  /// récupère les données de la vidéo
  /// importée ou à partir de l'état du projet
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

  CropModel _getCropModel(
    BuildContext context,
  ) {
    final CropSelectorState cropState =
        context.read<CropSelectorBloc>().state;

    return CropModel(
      cropX: cropState.cropX,
      cropY: cropState.cropY,
      cropWidth: cropState.cropWidth,
      cropHeight: cropState.cropHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RunBloc, RunState>(
      listener: (context, state) {
        if (state is RunSuccess) {
          context.read<ModalBloc>().add(
                const OnOpenModal(
                  title: "C'est prêt ! 🎉",
                  message: "Votre vidéo a été traitée avec succès.",
                ),
              );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is RunInProgress;

        return ElevatedButton(
          onPressed: !isLoading && hasActiveTool
              ? () {
                  final VideoDataModel videoDataModel = _getVideoDataModel(
                    context,
                  );

                  /// récupère les données de la vidéo (pour la taille)
                  final VideoState videoState = context.read<VideoBloc>().state;

                  final SizeModel fileSize = videoDataModel.size;
                  final SizeModel videoSize = SizeModel(
                    videoState.maxWidth,
                    videoState.maxHeight,
                  );
                  final CropModel crop = _getCropModel(
                    context,
                  );

                  context.read<RunBloc>().add(
                        OnRunEvent(
                          videoDataModel,
                          fileSize,
                          videoSize,
                          crop,
                          null,
                        ),
                      );
                }
              : null,
          child: const Text('Crop'),
        );
      },
    );
  }
}
