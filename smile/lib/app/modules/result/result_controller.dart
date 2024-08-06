import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/core/widgets/smile.dart';

class ResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxString _rt_img_path = ''.obs;
  String get rt_img_path => _rt_img_path.value;
  late SmileInfo smile_info;

  List<Widget> smile_data = [];

  late AnimationController animationController;
  late Animation<double> animation;

  _setupAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 100.0).animate(animationController);
  }

  _startAnimation() {
    animationController.forward(from: 0.0);
  }

  /*void build_smile_data() {
    // most_posterior_maxillary_teeth
    Widget most_posterior_maxillary_teeth = build_a_bar(
        smile_info['most_posterior_maxillary_teeth'],
        12,
        'Most posterior maxillary teeth');
    smile_data.add(most_posterior_maxillary_teeth);

    // arc_ratio
    Widget arc_ratio = build_a_bar(smile_info['arc_ratio'], 100, 'Arc ratio');
    smile_data.add(arc_ratio);

    //buccal_corridor
    Widget buccal_corridor =
        build_a_bar(smile_info['buccal_corridor'], 50, 'Buccal corridor');
    smile_data.add(buccal_corridor);

    update();
  }
*/
  Widget build_a_bar(int value, int maxValue, String title) {
    //var maxWidth = Get.width * 0.8;

    return Container(
        width: Get.width,
        child: Column(
          children: <Widget>[
            NormalText(title),
            Row(
              children: [
                Stack(children: [
                  Container(
                    width: Get.width * 0.8,
                    height: 20,
                    color: Colors.grey,
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Container(
                      color: Colors.amber,
                      width: Get.width *
                          0.8 *
                          min(
                            value / maxValue,
                            animation.value / 100,
                          ),

                      height: 20,
                      //child: NormalText('${animation.value}'),
                    ),
                  ),
                ]),
                NormalText('$value'),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }

  @override
  void onInit() {
    super.onInit();
    _rt_img_path.value = Get.arguments['img'];
    smile_info = SmileInfo.fromJson(Get.arguments['smile_info']);

    _setupAnimation();
    //build_smile_data();
  }

  @override
  void onReady() {
    super.onReady();
    _startAnimation();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
