import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/modules/setting/setting_controller.dart';

// 自定义的 Widget
class MainFrame extends StatelessWidget {
  final Widget? child;

  // 构造函数，传入一个文本参数
  MainFrame({this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Color.fromRGBO(255, 255, 255, 1),
        width: Get.width,
        child: child,
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  final String data;
  final Color? color;
  NormalText(this.data, {this.color});

  @override
  Widget build(BuildContext context) {
    final SettingController settingController = Get.put(SettingController());

    return Obx(() => Text(
          data,
          style: TextStyle(
              fontSize: settingController.selectedFontSize, color: color),
        ));
  }
}

class SettingBox extends StatelessWidget {
  final title;
  final Widget? child;

  SettingBox({this.title, this.child});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 0.75), // 上边框
          bottom: BorderSide(color: Colors.black, width: 0.75), // 下边框
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: NormalText(title),
          )
        ],
      ));
}
