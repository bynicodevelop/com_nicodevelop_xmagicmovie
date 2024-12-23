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

  Future<void> extractAudio(
    String projectId,
    String sourceFileName,
  ) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final String videoPath = '${workingDir.path}/$projectId/$sourceFileName';

    // Si le fichier audio existe déjà, on ne le recrée pas
    final String audioPath = fileManager.replaceFileExtension(videoPath, 'aac');
    final File audioFile = File(audioPath);

    if (audioFile.existsSync()) {
      debugPrint(
          'Le fichier audio existe déjà. Chargement du fichier existant.');
      return;
    }

    if (!File(videoPath).existsSync()) {
      final String message =
          'Erreur : Le fichier vidéo n\'existe pas à ce chemin : $videoPath';

      debugPrint(message);
      throw Exception(message);
    }

    final String ffmpegCommand =
        '-i "$videoPath" -vn -acodec copy -y "$audioPath"';

    try {
      final session = await FFmpegKit.executeAsync(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      if (returnCode == null || !returnCode.isValueSuccess()) {
        final String? error = await session.getOutput();
        throw Exception('Failed to extract audio: $error');
      }

      debugPrint("Audio extracted successfully. Output path: $audioPath");
    } catch (e) {
      throw Exception('Error while extracting audio: $e');
    }
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

      if (!File(videoPath).existsSync()) {
        debugPrint(
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

  Future<String?> getCoppedVideoPath(
    String projectId,
    String sourceFileName,
  ) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final String croppedVideoPath =
        '${workingDir.path}/$projectId/cropped_$sourceFileName';

    if (!File(croppedVideoPath).existsSync()) {
      debugPrint(
          'Erreur : Le fichier vidéo n\'existe pas à ce chemin : $croppedVideoPath');
      return null;
    }

    return croppedVideoPath;
  }

  Future<String?> cropVideo(
    VideoDataModel file,
    SizeModel stageSize, // Taille du stage (zone visible)
    CropModel crop, // Coordonnées de crop relatives au stage
    double zoomScale, // Zoom/dézoom de la vidéo
    void Function(int) onProgress,
  ) async {
    final Directory workingDir = await fileManager.getWorkingDirectory();
    final String inputPath = file.path;
    final double durationMs = await _getVideoDuration(inputPath);

    final String outputPath = fileManager.replaceFileExtension(
      '${workingDir.path}/${file.projectId}/cropped_${file.uniqueFileName}',
      'mp4',
    );

    final File fileExists = File(outputPath);
    if (fileExists.existsSync()) {
      fileExists.deleteSync();
    }

    // Convertir zoomScale en facteur d'échelle pour le dézoom
    final double scaleFactor = 1 + (zoomScale / 100);

    // Calcul des dimensions après dézoom/zoom
    int scaledWidth = (stageSize.width * scaleFactor).round();
    int scaledHeight = (stageSize.height * scaleFactor).round();

    // Aligner sur des multiples de 2 pour éviter les problèmes avec FFmpeg
    scaledWidth = (scaledWidth / 2).floor() * 2;
    scaledHeight = (scaledHeight / 2).floor() * 2;

    // Calcul du padding pour centrer la vidéo dézoomée dans le stage
    int offsetX = ((stageSize.width - scaledWidth) / 2).round();
    int offsetY = ((stageSize.height - scaledHeight) / 2).round();

    // Aligner les offsets sur des multiples de 2
    offsetX = (offsetX / 2).floor() * 2;
    offsetY = (offsetY / 2).floor() * 2;

    // Recalculer les coordonnées du crop en fonction du padding et du facteur d'échelle
    int adjustedCropX = ((crop.cropX - offsetX) / scaleFactor)
        .clamp(0, scaledWidth - 1)
        .round();
    int adjustedCropY = ((crop.cropY - offsetY) / scaleFactor)
        .clamp(0, scaledHeight - 1)
        .round();

    // Les dimensions du crop doivent également être adaptées au facteur d'échelle
    int cropWidth = (crop.cropWidth / scaleFactor)
        .clamp(1, scaledWidth - adjustedCropX)
        .round();
    int cropHeight = (crop.cropHeight / scaleFactor)
        .clamp(1, scaledHeight - adjustedCropY)
        .round();

    // Aligner les dimensions du crop sur des multiples de 2
    cropWidth = (cropWidth / 2).floor() * 2;
    cropHeight = (cropHeight / 2).floor() * 2;

    // Construction du filtre FFmpeg avec centrage explicite
    final String filter =
        'scale=$scaledWidth:$scaledHeight, pad=${stageSize.width}:${stageSize.height}:(ow-iw)/2:(oh-ih)/2, crop=$cropWidth:$cropHeight:$adjustedCropX:$adjustedCropY';

    final String ffmpegCommand =
        '-i "$inputPath" -filter_complex "$filter" -c:v libx264 -preset fast -c:a aac "$outputPath"';

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
