import 'package:get/get.dart';

import '../modules/setting/setting_binding.dart';
import '../modules/setting/setting_page.dart';

class SettingRoutes {
  SettingRoutes._();

  static const setting = '/setting';

  static final routes = [
    GetPage(
      name: setting,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
  ];
}
