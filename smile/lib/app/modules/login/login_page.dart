import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/setting/setting_controller.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final SettingController settingController = Get.put(SettingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: MainFrame(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Align(
                  alignment: Alignment.bottomLeft,
                  child: NormalText(
                    controller.alert,
                    color: Colors.red,
                  )),
            ),
            Obx(() {
              return Container(
                alignment: Alignment.topCenter,
                height: 80,
                child: TextField(
                  style:
                      TextStyle(fontSize: settingController.selectedFontSize),
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                  onChanged: (value) {
                    controller.username = value;
                    if (value.isEmpty) {
                      controller
                          .set_username_errorText('This field cannot be empty');
                    } else {
                      controller.set_username_errorText(null);
                    }
                  },
                ),
              );
            }),
            SizedBox(height: 20.0),
            Obx(() {
              return Container(
                alignment: Alignment.topCenter,
                height: 80,
                child: TextField(
                  obscureText: true,
                  style:
                      TextStyle(fontSize: settingController.selectedFontSize),
                  decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: controller.password_errorText),
                  onChanged: (value) {
                    controller.password = value;
                    if (value.isEmpty) {
                      controller
                          .set_password_errorText('This field cannot be empty');
                    } else {
                      controller.set_password_errorText(null);
                    }
                  },
                ),
              );
            }),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: controller.login,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(20.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // 设置圆角半径为10像素
                    ),
                  )),
              child: NormalText('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
