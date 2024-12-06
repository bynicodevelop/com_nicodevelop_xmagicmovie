import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class SizeModel extends Model {
  final double width;
  final double height;

  SizeModel(
    this.width,
    this.height,
  );

  @override
  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
      };
}
