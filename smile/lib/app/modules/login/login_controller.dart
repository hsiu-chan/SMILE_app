import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:smile/app/modules/setting/setting_page.dart';

class LoginController extends GetxController {
  RxString _alert = ''.obs;
  String get alert => _alert.value;

  RxString _username_errorText = ''.obs;
  String? get username_errorText =>
      _username_errorText.value == '' ? null : _username_errorText.value;

  RxString _password_errorText = ''.obs;
  String? get password_errorText =>
      _password_errorText.value == '' ? null : _password_errorText.value;

  String username = '';
  String password = '';

  late HiveUtil hiveUtil;

  void set_alert(String? a) {
    _alert.value = a ?? '';
    update();
    Future.delayed(Duration(seconds: 3), () {
      _alert.value = '';
    });
  }

  void set_username_errorText(String? e) {
    _username_errorText.value = e ?? '';
  }

  void set_password_errorText(String? e) {
    _password_errorText.value = e ?? '';
  }

  void login() {
    if (password == 'hi') {
      hiveUtil.userBox.put('username', username);
      Get.back();
      username = '';
      password = '';
    } else {
      set_alert('Failed');
    }
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
    username = '';
    password = '';
    super.dispose();
  }
}
