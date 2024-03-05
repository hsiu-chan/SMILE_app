import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:flutter_charts/flutter_charts.dart';

import 'result_controller.dart';

class ResultPage extends GetView<ResultController> {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResultController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultPage'),
        centerTitle: true,
      ),
      body: MainFrame(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'ResultPage is working',
                style: TextStyle(fontSize: 20),
              ),
              Image.file(File(controller.rt_img_path), fit: BoxFit.contain),
              SizedBox(height: 20.0),

              SizedBox(
                height: 30,
              ),
              //直方圖
              Container(
                  width: Get.width,
                  child: Column(
                    children: controller.smile_data,
                  ))
            ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.animationController.forward(from: 0.0);
        print(controller.animation);
      }),
      // TODO
    );
  }
}
