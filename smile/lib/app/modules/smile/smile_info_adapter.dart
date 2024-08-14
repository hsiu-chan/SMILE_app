import 'package:hive/hive.dart';

part 'smile_info_adapter.g.dart';

@HiveType(typeId: 0)
class SmileInfo extends HiveObject {
  @HiveField(0)
  final List<List<double>> mouthPoints;

  @HiveField(1)
  final List<List<double>> toothBoxes;

  @HiveField(2)
  final List<String> toothClasses;

  @HiveField(3)
  final double h2w;

  @HiveField(4)
  int? mostPosteriorMaxillaryTeethVisible;

  @HiveField(5)
  double? arcRatio;

  @HiveField(6)
  double? buccalCorridor;

  @HiveField(7)
  double? maxillaryTeethExposure;

  @HiveField(8)
  String path;

  SmileInfo({
    required this.mouthPoints,
    required this.toothBoxes,
    required this.toothClasses,
    required this.h2w,
    required this.mostPosteriorMaxillaryTeethVisible,
    required this.arcRatio,
    required this.buccalCorridor,
    required this.maxillaryTeethExposure,
    required this.path,
  });

  factory SmileInfo.fromJson(Map<String, dynamic> json) {
    print(json['mouth'][0][1].toDouble() * 2);
    return SmileInfo(
        mouthPoints: List<List<double>>.from(json['mouth']
            .map((point) =>
                List<double>.from([point[0].toDouble(), point[1].toDouble()]))
            .toList()),
        toothBoxes: List<List<double>>.from(json['tooth_boxes']
            .map((box) => List<double>.from([
                  box[0].toDouble(),
                  box[1].toDouble(),
                  box[2].toDouble(),
                  box[3].toDouble(),
                ]))
            .toList()),
        toothClasses: json.containsKey("tooth_cls")
            ? List<String>.from(json['tooth_cls'])
            : [],
        h2w: json["image"]["height"].toDouble() /
            json["image"]["width"].toDouble(),
        mostPosteriorMaxillaryTeethVisible:
            json.containsKey("most_posterior_maxillary_teeth_visible")
                ? json["most_posterior_maxillary_teeth_visible"]
                : null,
        arcRatio:
            json.containsKey("arc_ratio") ? json["arc_ratio"].toDouble() : null,
        buccalCorridor: json.containsKey("buccal_corridor")
            ? json["buccal_corridor"].toDouble()
            : null,
        maxillaryTeethExposure: json.containsKey("Maxillary_teeth_exposure")
            ? json["Maxillary_teeth_exposure"].toDouble()
            : null,
        path: json["path"]);
  }
}
