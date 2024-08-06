import 'dart:ui';

import 'package:get/get.dart';

class BoxController extends GetxController {
  RxDouble width = 100.0.obs;
  RxDouble height = 100.0.obs;
  RxDouble scale = 1.0.obs;
  RxInt box_height = 500.obs;

  Rx<Offset> offset = Offset.zero.obs;

  void updateScale(double newScale) {
    scale.value = newScale;
  }

  void updateOffset(Offset newOffset) {
    offset.value = newOffset;
  }
}
