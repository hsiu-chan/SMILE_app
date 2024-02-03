import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Center(
        child: TextButton(
            child: Text('go'), onPressed: () => Get.toNamed('/home')),
      ),
    );
  }
}
