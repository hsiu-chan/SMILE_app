import 'package:get/get.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:dio/dio.dart' as dio;
import 'package:smile/app/modules/home/home_controller.dart';
import 'package:smile/app/modules/home/home_page.dart';
import 'package:smile/app/modules/setting/setting_page.dart';
import 'package:smile/config.dart';

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
    Future.delayed(Duration(seconds: 15), () {
      _alert.value = '';
    });
  }

  void set_username_errorText(String? e) {
    _username_errorText.value = e ?? '';
  }

  void set_password_errorText(String? e) {
    _password_errorText.value = e ?? '';
  }

  Future<void> login() async {
    final dioInstance = dio.Dio();

    final formData = dio.FormData.fromMap({
      'username': username,
      'password': password,
    });

    try {
      // 發送 POST 請求
      final response = await dioInstance.post(
        '${hiveUtil.get("API_URL")}$LOGIN_API',
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // 確保回應的內容是 JSON 格式
      if (response.data is Map) {
        // 處理 JSON 數據
        String msg = response.data["message"];
        if (msg == "success") {
          hiveUtil.userBox.put('username', username);
          Get.back();
          username = '';
          password = '';
        } else {
          set_alert('${msg}');
        }
      } else {
        set_alert('Unexpected response format');
      }
    } catch (e) {
      set_alert('Error occurred: $e');
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
