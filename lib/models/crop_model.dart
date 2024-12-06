import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class CropModel extends Model {
  final double cropX;
  final double cropY;
  final double cropWidth;
  final double cropHeight;

  CropModel({
    required this.cropX,
    required this.cropY,
    required this.cropWidth,
    required this.cropHeight,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'cropX': cropX,
      'cropY': cropY,
      'cropWidth': cropWidth,
      'cropHeight': cropHeight,
    };
  }
}
