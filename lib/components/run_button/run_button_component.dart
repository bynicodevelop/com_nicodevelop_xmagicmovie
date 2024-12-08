import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_state.dart';
import 'package:com_nicodevelop_xmagicmovie/components/run_button/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RunButtonComponent extends StatelessWidget {
  final bool hasActiveTool;

  const RunButtonComponent({
    super.key,
    this.hasActiveTool = false,
  });

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
                  final UploadState uplaodState =
                      context.read<UploadBloc>().state;
                  final VideoState videoState = context.read<VideoBloc>().state;
                  final CropSelectorState cropState =
                      context.read<CropSelectorBloc>().state;

                  final VideoDataModel file = uplaodState.files.first;
                  final SizeModel fileSize = file.size;
                  final SizeModel videoSize = SizeModel(
                    videoState.maxWidth,
                    videoState.maxHeight,
                  );
                  final CropModel crop = CropModel(
                    cropX: cropState.cropX,
                    cropY: cropState.cropY,
                    cropWidth: cropState.cropWidth,
                    cropHeight: cropState.cropHeight,
                  );

                  context.read<RunBloc>().add(
                        OnRunEvent(
                          file,
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
