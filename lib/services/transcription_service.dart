import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/gateway/openai_gateway.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/sentence_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/transcription.dart';

class TranscriptionService {
  final OpenaiGateway openaiGateway;
  final VideoManager videoManager;
  final Transcription transcription;

  TranscriptionService(
    this.openaiGateway,
    this.videoManager,
    this.transcription,
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

  List<SentenceModel> createSentences(
    TranscriptionModel transcriptionModel,
  ) {
    final TranscriptionWithGroupedWordsModel groupedTranscription =
        transcription.groupWords(transcriptionModel);

    return transcription.createSentencesFromGroups(groupedTranscription);
  }
}
