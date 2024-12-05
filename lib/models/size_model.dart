import 'package:com_nicodevelop_xmagicmovie/models/model.dart';

class Size extends Model {
  final double width;
  final double height;

  Size(
    this.width,
    this.height,
  );

  @override
  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
      };
}
