import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';
import 'package:smile/config.dart';

class ResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late SmileInfo smile_info;

  List<Widget> smile_data = [];

  late AnimationController animationController;
  late Animation<double> animation;
  bool isReview = false;

  _setupAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 100.0).animate(animationController);
  }

  _startAnimation() {
    animationController.forward(from: 0.0);
  }

  void build_smile_data() {
    // most_posterior_maxillary_teeth
    Widget most_posterior_maxillary_teeth_visible = build_a_bar(
        smile_info.mostPosteriorMaxillaryTeethVisible == null
            ? null
            : smile_info.mostPosteriorMaxillaryTeethVisible!.toDouble(),
        12,
        'Most posterior maxillary teeth visible');

    smile_data.add(most_posterior_maxillary_teeth_visible);

    // arc_ratio
    Widget arc_ratio = build_a_bar(smile_info.arcRatio, 3, 'Arc ratio');
    smile_data.add(arc_ratio);

    //buccal_corridor
    Widget buccal_corridor =
        build_a_bar(smile_info.buccalCorridor, 0.5, 'Buccal corridor');
    smile_data.add(buccal_corridor);

    //

    Widget Maxillary_teeth_exposure = build_a_bar(
        smile_info.maxillaryTeethExposure, 1, 'Maxillary teeth exposure rate');
    smile_data.add(Maxillary_teeth_exposure);

    update();
  }

  Widget build_a_bar(double? value, double maxValue, String title) {
    double height = 25;

    return Container(
        width: MAINFRAME_WIDTH,
        //color: Colors.red,
        child: Column(
          children: <Widget>[
            NormalText(title),
            Stack(children: [
              Container(
                width: MAINFRAME_WIDTH,
                height: height,
                color: Colors.grey,
              ),
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Container(
                  color: Theme.of(context).focusColor,
                  width: MAINFRAME_WIDTH *
                      min(
                        (value ?? 0).abs() / maxValue,
                        animation.value / 100,
                      ),

                  height: height,
                  //child: NormalText('${animation.value}'),
                ),
              ),
              NormalText(value == null ? "Null" : value.toStringAsFixed(2)),
            ]),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }

  Future<void> _saveResult() async {
    // 構建存檔位置
    final app_dir = await getApplicationDocumentsDirectory();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final String save_path =
        "${app_dir.path}/$formattedDate.${smile_info.path.split('.').last}";

    // 存檔並更新路徑
    await File(smile_info.path).copy(save_path);
    smile_info.path = save_path;

    // 打開 Hive 並檢查 Box
    try {
      HiveUtil hiveUtil = await HiveUtil.getInstance();

      if (!hiveUtil.smileInfoBox.isOpen) {
        hiveUtil.smileInfoBox = await Hive.openBox<SmileInfo>("smileInfoBox");
      }

      // 存入 Hive Box
      await hiveUtil.smileInfoBox.put(formattedDate, smile_info);
      print("Smile info saved successfully to Hive.");
    } catch (e) {
      print("Error saving smile info to Hive: $e");
    }

    return;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    smile_info = Get.arguments['smile_info'];
    isReview = !(Get.arguments["review"] == null);

    _setupAnimation();

    build_smile_data();
  }

  @override
  void onReady() {
    super.onReady();
    _startAnimation();
  }

  @override
  void onClose() {
    animationController.dispose();

    if (!isReview) {
      Get.defaultDialog(
          title: 'Hints',
          middleText: "Do you want to save the result?",
          textConfirm: 'Yes',
          textCancel: 'No',
          onCancel: () {},
          onConfirm: () async {
            await _saveResult(); // 執行保存操作
            Get.back(); // 關閉對話框
          });
    }

    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
