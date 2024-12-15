import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
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

  Future<Uint8List?> extractThumbnail({
    required String projectId,
    required String sourceFileName,
  }) async {
    try {
      final Directory workingDir = await fileManager.getWorkingDirectory();
      final String videoPath = '${workingDir.path}/$projectId/$sourceFileName';
      final String thumbnailPath =
          '${workingDir.path}/$projectId/thumbnail.png';

      print('Chemin de la vidéo : $videoPath');
      print('Chemin de la miniature : $thumbnailPath');

      if (!File(videoPath).existsSync()) {
        print(
            'Erreur : Le fichier vidéo n\'existe pas à ce chemin : $videoPath');
        return null;
      }

      // Vérifier si la miniature existe déjà
      final File thumbnailFile = File(thumbnailPath);
      if (thumbnailFile.existsSync()) {
        debugPrint('La miniature existe déjà. Chargement du fichier existant.');
        return await thumbnailFile.readAsBytes();
      }

      // Commande FFmpeg pour extraire une image (première frame) de la vidéo
      final String ffmpegCommand =
          '-i "$videoPath" -vf "thumbnail" -frames:v 1 "$thumbnailPath"';

      final completer = Completer<Uint8List?>();

      await FFmpegKit.executeAsync(ffmpegCommand, (session) async {
        final returnCode = await session.getReturnCode();

        if (returnCode != null && returnCode.isValueSuccess()) {
          if (await thumbnailFile.exists()) {
            final Uint8List bytes = await thumbnailFile.readAsBytes();
            completer.complete(bytes);
          } else {
            debugPrint('Erreur : Le fichier miniature n\'a pas été créé.');
            completer.complete(null);
          }
        } else {
          final String? error = await session.getOutput();
          debugPrint('Erreur FFmpeg : $error');
          completer.complete(null);
        }
      });

      return completer.future;
    } catch (e) {
      debugPrint('Erreur lors de l\'extraction du thumbnail avec FFmpeg : $e');
      return null;
    }
  }

  Future<String?> cropVideo(
    VideoDataModel file,
    SizeModel videoSize,
    CropModel crop,
    void Function(int) onProgress,
  ) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final String inputPath = file.path;
    final double durationMs = await _getVideoDuration(inputPath);

    final String outputPath = fileManager.replaceFileExtension(
        '${workingDir.path}/${file.projectId}/cropped_${file.uniqueFileName}',
        'mp4');

    final File fileExists = File(outputPath);
    if (fileExists.existsSync()) {
      fileExists.deleteSync();
    }

    final String ffmpegCommand =
        '-i "$inputPath" -filter:v "crop=${crop.cropWidth}:${crop.cropHeight}:${crop.cropX}:${crop.cropY}" -c:v libx264 -preset fast -c:a aac "$outputPath"';

    try {
      final completer = Completer<void>();

      FFmpegKit.executeAsync(
        ffmpegCommand,
        (session) async {
          final returnCode = await session.getReturnCode();
          if (returnCode != null && returnCode.isValueSuccess()) {
            debugPrint("Video cropped successfully. Output path: $outputPath");
            completer.complete();
          } else {
            final String? error = await session.getOutput();
            completer.completeError(Exception('Failed to crop video: $error'));
          }
        },
        null,
        (statistics) {
          final double currentTime = statistics.getTime();
          final int progress =
              ((currentTime / durationMs) * 100).clamp(0, 100).toInt();

          onProgress(progress);
        },
      );

      await completer.future;

      return outputPath;
    } catch (e) {
      throw Exception('Error while cropping video: $e');
    }
  }

  Future<double> _getVideoDuration(String inputPath) async {
    final session = await FFmpegKit.execute('-i "$inputPath"');
    final String? output = await session.getOutput();

    final regex = RegExp(r'Duration: (\d+):(\d+):(\d+\.\d+)');
    final match = regex.firstMatch(output ?? '');

    if (match != null) {
      final int hours = int.parse(match.group(1)!);
      final int minutes = int.parse(match.group(2)!);
      final double seconds = double.parse(match.group(3)!);
      return ((hours * 3600) + (minutes * 60) + seconds) * 1000;
    } else {
      throw Exception('Unable to get video duration');
    }
  }

  Future<VideoDataModel> createVideoDataModel(
    String projectId,
    String sourceFileName,
  ) async {
    final String videoPath =
        await fileManager.getFilePath(projectId, sourceFileName);

    return _buildVideoDataModel(
      projectId: projectId,
      filePath: videoPath,
      fileName: sourceFileName,
    );
  }

  Future<VideoDataModel> processFile(XFile file) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final Map<String, String> uniqueFileName =
        await fileManager.generateUniqueFileName(file);
    final String projectPath = "${workingDir.path}/${uniqueFileName['hash']}";
    final String filePath = '$projectPath/${uniqueFileName['fileName']}';

    final Directory directory = Directory(projectPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    await file.saveTo(filePath);

    return _buildVideoDataModel(
      projectId: uniqueFileName['hash']!,
      filePath: filePath,
      fileName: uniqueFileName['fileName']!,
    );
  }

  Future<VideoDataModel> _buildVideoDataModel({
    required String projectId,
    required String filePath,
    required String fileName,
  }) async {
    final XFile videoFile = XFile(filePath);
    final SizeModel size = await getVideoSize(videoFile);

    return VideoDataModel(
      projectId: projectId,
      name: fileName,
      path: filePath,
      uniqueFileName: fileName,
      xfile: videoFile,
      size: size,
    );
  }
}
