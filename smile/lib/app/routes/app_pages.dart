import 'package:smile/app/routes/result_routes.dart';

import 'setting_routes.dart';

import 'home_routes.dart';

class AppPages {
  AppPages._();

  static const initial = '/setting';

  static final routes = [
    ...HomeRoutes.routes,
    ...SettingRoutes.routes,
    ...ResultRoutes.routes
  ];
}
