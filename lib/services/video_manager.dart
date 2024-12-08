import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';

class VideoManager {
  final FileManager fileManager;

  const VideoManager({
    required this.fileManager,
  });

  Future<SizeModel> getVideoSize(XFile file) async {
    final String filePath = file.path;

    final session = await FFmpegKit.execute('-i "$filePath"');
    final String? output = await session.getOutput();

    if (output == null) {
      throw Exception('Failed to get video size');
    }

    final regex = RegExp(r'Video:.* (\d+)x(\d+)', multiLine: true);
    final match = regex.firstMatch(output);

    if (match == null) {
      throw Exception('Failed to get video size');
    }

    final width = int.parse(match.group(1)!);
    final height = int.parse(match.group(2)!);

    return SizeModel(
      width.toDouble(),
      height.toDouble(),
    );
  }

  Future<void> cropVideo(
    VideoDataModel file,
    SizeModel videoSize,
    CropModel crop,
  ) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final String inputPath = file.path;

    // Définir un chemin pour le fichier de sortie
    final String outputPath =
        '${workingDir.path}/${file.projectId}/cropped_${file.uniqueFileName}';

    // File exists
    final File fileExists = File(outputPath);

    if (fileExists.existsSync()) {
      fileExists.deleteSync();
    }

    // Construire la commande FFmpeg pour recadrer la vidéo
    final String ffmpegCommand =
        '-i "$inputPath" -filter:v "crop=${crop.cropWidth}:${crop.cropHeight}:${crop.cropX}:${crop.cropY}" -c:a copy "$outputPath"';

    try {
      final session = await FFmpegKit.execute(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      if (returnCode != null && returnCode.isValueSuccess()) {
        debugPrint("Video cropped successfully. Output path: $outputPath");
      } else {
        final String? error = await session.getOutput();
        throw Exception('Failed to crop video: $error');
      }
    } catch (e) {
      throw Exception('Error while cropping video: $e');
    }
  }
}
