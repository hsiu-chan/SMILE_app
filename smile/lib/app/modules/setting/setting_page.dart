import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/login/login_page.dart';

import 'setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('SettingPage'),
          centerTitle: true,
        ),
        body: MainFrame(
          child: Column(children: <Widget>[
            Icon(
              Icons.account_circle,
              size: Get.width * 0.7,
            ),
            SizedBox(
              height: 50,
              child: controller.username == null
                  ? TextButton(
                      onPressed: () => Get.to(LoginPage()),
                      child: NormalText('Log in'))
                  : Text(controller.username!),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(children: <Widget>[SettingBox(title: '字體大小')]),
              ),
            ),
          ]),
        ));
  }
}
