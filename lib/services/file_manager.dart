import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:crypto/crypto.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<Directory> getWorkingDirectory() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    final Directory workingDir = Directory(
      '${appDocDir.path}/$kWorkDir',
    );

    if (!await workingDir.exists()) {
      await workingDir.create(recursive: true);
    }

    return workingDir;
  }

  static String getFileName(XFile file) {
    return file.path.split('/').last;
  }

  static Future<String> generateUniqueFileName(XFile file) async {
    final String extension = file.path.split('.').last;

    final bytes = await file.readAsBytes();
    final hash = md5.convert(bytes);

    return '$hash.$extension';
  }

  static Future<String> getFilePath(String fileName) async {
    final Directory workingDir = await getWorkingDirectory();
    return '${workingDir.path}/$fileName';
  }

  static Future<Size> getVideoSize(XFile file) async {
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

    return Size(
      width.toDouble(),
      height.toDouble(),
    );
  }
}
