import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smile/app/modules/home/home_controller.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';

/*class SmileInfo {
  final List<List<double>> mouthPoints;
  final List<List<double>> toothBoxes;
  final List<String> toothClasses;
  final double h2w;
  final int most_posterior_maxillary_teeth_visible;
  final double arc_ratio;
  final double buccal_corridor;
  final double Maxillary_teeth_exposure;
  final String path;

  SmileInfo(
      {required this.mouthPoints,
      required this.toothBoxes,
      required this.toothClasses,
      required this.h2w,
      required this.most_posterior_maxillary_teeth_visible,
      required this.arc_ratio,
      required this.buccal_corridor,
      required this.Maxillary_teeth_exposure,
      required this.path});

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
        toothClasses: List<String>.from(json['tooth_cls']),
        h2w: json["image"]["height"].toDouble() /
            json["image"]["width"].toDouble(),
        most_posterior_maxillary_teeth_visible:
            json["most_posterior_maxillary_teeth_visible"],
        arc_ratio: json["arc_ratio"].toDouble(),
        buccal_corridor: json["buccal_corridor"].toDouble(),
        Maxillary_teeth_exposure: json["Maxillary_teeth_exposure"].toDouble(),
        path: json["path"]);
  }
}*/

class SmilePainter extends CustomPainter {
  final SmileInfo smileInfo;

  SmilePainter(this.smileInfo);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5;

    final rectPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5;

    // 繪製口腔輪廓
    final path = Path()
      ..moveTo(
        smileInfo.mouthPoints[0][0] * size.width,
        smileInfo.mouthPoints[0][1] * size.height,
      );

    for (var point in smileInfo.mouthPoints.skip(1)) {
      path.lineTo(
        point[0] * size.width,
        point[1] * size.height,
      );
    }
    path.close();
    canvas.drawPath(path, paint);

    // 繪製牙齒
    for (var i = 0; i < smileInfo.toothBoxes.length; i++) {
      final box = smileInfo.toothBoxes[i];
      final rect = Rect.fromLTWH(
        box[0] * size.width - (box[2] * size.width) / 2,
        box[1] * size.height - (box[3] * size.height) / 2,
        box[2] * size.width,
        box[3] * size.height,
      );
      canvas.drawRect(rect, rectPaint);
    }

    // 方框
    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    canvas.drawRect(rect, rectPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is SmilePainter && oldDelegate.smileInfo != smileInfo;
  }
}
