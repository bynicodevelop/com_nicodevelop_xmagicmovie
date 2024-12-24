import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:dart_openai/dart_openai.dart';

class OpenaiGateway {
  OpenaiGateway(
    String apiKey,
  ) {
    OpenAI.apiKey = apiKey;
  }

  Future<TranscriptionModel> transcribeAudioToText({
    required File audioFile,
  }) async {
    final OpenAIAudioModel transcription =
        await OpenAI.instance.audio.createTranscription(
      file: audioFile,
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.verbose_json,
      timestamp_granularities: [OpenAIAudioTimestampGranularity.word],
    );

    return TranscriptionModel(
      text: transcription.text,
      words: (transcription.words ?? [])
          .map((word) => WordModel.fromJson(word.toMap()))
          .toList(),
      duration: transcription.duration,
      language: transcription.language,
    );
  }
}
