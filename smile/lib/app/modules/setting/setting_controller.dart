import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:dio/dio.dart' as dio;
import 'package:smile/config.dart';

class SettingController extends GetxController {
  RxDouble _selectedFontSize = 20.0.obs;
  double get selectedFontSize => _selectedFontSize.value;
  RxInt _language_ID = 0.obs;
  int get language_ID => _language_ID.value;
  final List<String> languages = ["English", "中文"];

  late HiveUtil hiveUtil;

  Future<void> logout() async {
    try {
      //TODO: 伺服器 logout
      /*final dioInstance = dio.Dio();

      final response = await dioInstance.post(
        LOGOUT_API,
      );*/
      hiveUtil.userBox.delete('username');
    } catch (e) {
      Get.defaultDialog(
        title: '提示',
        middleText: "Fail: $e",
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Check'),
        ),
      );
    }
  }

  void changeLanguage() {
    _language_ID.value += 1;
    if (_language_ID.value == languages.length) {
      _language_ID.value = 0;
    }
    hiveUtil.userBox.put('language', _language_ID.value);
    //TODO: 設定所有頁面語言
  }

  @override
  Future<void> onInit() async {
    hiveUtil = await HiveUtil.getInstance();
    _language_ID.value = hiveUtil.userBox.get("language") ?? 0;
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
