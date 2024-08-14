import 'package:smile/app/routes/history.dart';
import 'package:smile/app/routes/login_routes.dart';
import 'package:smile/app/routes/result_routes.dart';

import 'setting_routes.dart';

import 'home_routes.dart';

class AppPages {
  AppPages._();

  static const initial = '/home';

  static final routes = [
    ...HomeRoutes.routes,
    ...SettingRoutes.routes,
    ...ResultRoutes.routes,
    ...LoginRoutes.routes,
    ...HistoryRoutes.routes
  ];
}
