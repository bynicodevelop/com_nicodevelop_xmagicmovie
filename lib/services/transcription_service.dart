import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/gateway/openai_gateway.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';

class TranscriptionService {
  final OpenaiGateway openaiGateway;
  final VideoManager videoManager;

  TranscriptionService(
    this.openaiGateway,
    this.videoManager,
  );

  Future<TranscriptionModel> transcribeAudioToText(
    String projectId,
    String sourceFileName,
  ) async {
    final String audioFileName = await videoManager.getAudioFilePath(
      projectId,
      sourceFileName,
    );

    final File audioFile = File(audioFileName);

    return openaiGateway.transcribeAudioToText(
      audioFile: audioFile,
    );
  }
}
