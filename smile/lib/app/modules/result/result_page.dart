import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:smile/app/modules/smile/smile.dart';
import 'package:smile/app/modules/result/box_controller.dart';

import 'result_controller.dart';

class ResultPage extends GetView<ResultController> {
  final ResultController controller = Get.put(ResultController());
  final BoxController box_controller = Get.put(BoxController());

  @override
  Widget build(BuildContext context) {
    Get.put(ResultController());
    double box_height = 300;
    double box_width = Get.width;

    // Smile_info

    return Scaffold(
      appBar: AppBar(
        title: const Text('辨識結果'),
        centerTitle: true,
      ),
      body: MainFrame(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your smile',
                style: TextStyle(fontSize: 20),
              ),
              //,
              SizedBox(height: 20.0),
              Container(
                  height: box_height,
                  child: Expanded(
                    child: DraggableAndResizableWidget(
                      height: box_height,
                      width: box_width,
                    ),
                  )),

              /*Obx(() => Text(
                    'Your ${box_controller.offset.value} ',
                    style: TextStyle(fontSize: 20),
                  )),*/

              //直方圖
              SizedBox(height: 20.0),

              SingleChildScrollView(
                  child: Column(
                children: controller.smile_data,
              ))
            ]),
      ),

      /*floatingActionButton: FloatingActionButton(onPressed: () {
        controller.animationController.forward(from: 0.0);
        print(controller.animation);
      }),*/
    );
  }
}

class DraggableAndResizableWidget extends StatelessWidget {
  late double height;
  late double width;

  DraggableAndResizableWidget({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final BoxController boxController = Get.put(BoxController());
    final ResultController controller = Get.put(ResultController());
    final double pic_width = Get.width;
    final double pic_height = pic_width * controller.smile_info.h2w;

    return Obx(() {
      return Container(
          height: 200,
          child: ClipRect(
            child: GestureDetector(
              onDoubleTap: () {
                boxController.updateScale(1);
                boxController.updateOffset(Offset(0, 0));
              },
              onScaleUpdate: (details) {
                double newScale = details.scale * boxController.scale.value;
                boxController.updateScale(newScale);

                double newOffsetX =
                    boxController.offset.value.dx + details.focalPointDelta.dx;
                double newOffsetY =
                    boxController.offset.value.dy + details.focalPointDelta.dy;

                // 計算圖片的新寬高
                double scaledPicWidth = pic_width * newScale;
                double scaledPicHeight = pic_height * newScale;

                // 設定邊界限制
                const double boundaryMargin = 10.0;

                // 計算圖片在ClipRect內部需要保留的範圍
                double minOffsetX = -scaledPicWidth + boundaryMargin;
                double maxOffsetX = width - boundaryMargin - 35;
                double minOffsetY = -scaledPicHeight + boundaryMargin;
                double maxOffsetY = height - boundaryMargin;

                // 限制偏移量，使圖片的邊界至少保留 10 像素
                newOffsetX = min(max(minOffsetX, newOffsetX), maxOffsetX);
                newOffsetY = min(max(minOffsetY, newOffsetY), maxOffsetY);

                boxController.updateOffset(Offset(newOffsetX, newOffsetY));
              },

              // CHILD
              child: Container(
                  color: Colors.grey,
                  //constraints: BoxConstraints(maxHeight: 100),
                  //height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: boxController.offset.value.dx,
                        top: boxController.offset.value.dy,
                        child: Container(
                          color: Colors.transparent,
                          child: Transform.scale(
                            scale: boxController.scale.value,
                            child: Stack(
                              children: <Widget>[
                                Image.file(
                                  File(controller.smile_info.path),
                                  width: pic_width,
                                  height: pic_height,
                                  fit: BoxFit.cover,
                                ),
                                CustomPaint(
                                  size: Size(pic_width, pic_height),
                                  painter: SmilePainter(controller.smile_info),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ));
    });
  }
}
