import 'package:get/get.dart';

class SettingController extends GetxController {
  RxString? _username;
  String? get username => _username?.value;

  RxDouble _selectedFontSize = 20.0.obs;
  double get selectedFontSize => _selectedFontSize.value;

  @override
  void onInit() {
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
}
