import 'dart:ffi';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';

class SettingController extends GetxController {
  RxDouble _selectedFontSize = 20.0.obs;
  double get selectedFontSize => _selectedFontSize.value;

  late HiveUtil hiveUtil;

  Future<void> logout() async {
    hiveUtil.userBox.delete('username');
  }

  @override
  Future<void> onInit() async {
    hiveUtil = await HiveUtil.getInstance();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
