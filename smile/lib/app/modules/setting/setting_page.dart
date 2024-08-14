import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/login/login_page.dart';

import 'setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingController());
    Widget line = const Divider(height: 0.75, color: Colors.grey);

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
            Center(
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: ValueListenableBuilder(
                    valueListenable: controller.hiveUtil.userBox.listenable(),
                    builder: (context, Box box, widget) {
                      String? username =
                          box.get('username', defaultValue: null);

                      return (username == '' || username == null)
                          ? TextButton(
                              onPressed: () => Get.to(const LoginPage()),
                              child: NormalText('Login'))
                          : NormalText(username);
                    }),
              ),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.0),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(children: <Widget>[
                  SettingBox(title: 'Font size'),
                  line,
                  SettingBox(
                    title: "Language",
                    child: Obx(
                      () => NormalText(
                          controller.languages[controller.language_ID]),
                    ),
                    onTap: controller.changeLanguage,
                  ),
                  line,
                  SettingBox(
                    title: 'Logout',
                    onTap: controller.logout,
                  )
                ]),
              ),
            ),
          ]),
        ));
  }
}
