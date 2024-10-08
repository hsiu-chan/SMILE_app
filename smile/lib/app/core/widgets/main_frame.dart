import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/modules/setting/setting_controller.dart';
import 'package:smile/config.dart';

// 自定义的 Widget
class MainFrame extends StatelessWidget {
  final Widget? child;

  // 构造函数，传入一个文本参数
  MainFrame({this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(MAINFRAME_PADDING),
        width: Get.width,
        height: Get.height,
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
  void Function()? onTap;

  SettingBox({this.title, this.child, this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        color: Color.fromARGB(0, 255, 255, 1),
        //color: Color.fromARGB(255, 255, 69, 2),
        //color: Color.fromARGB(255, 255, 69, 2),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: NormalText(title),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: child ?? SizedBox(),
              ),
            ),
          ],
        ),
      ));
}
