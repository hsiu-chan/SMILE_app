import 'package:get/get.dart';

class ResultController extends GetxController {
  RxString _rt_img_path = ''.obs;
  String get rt_img_path => _rt_img_path.value;

  @override
  void onInit() {
    super.onInit();
    _rt_img_path.value = Get.arguments['img'];
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
