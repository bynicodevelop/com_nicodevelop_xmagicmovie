import 'package:dart_openai/dart_openai.dart';

class OpenaiGateway {
  OpenaiGateway(
    String apiKey,
  ) {
    OpenAI.apiKey = apiKey;
  }
}
