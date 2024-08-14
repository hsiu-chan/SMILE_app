import 'home_routes.dart';
import 'history_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';

  static final routes = [
    ...HomeRoutes.routes,
		...HistoryRoutes.routes,
  ];
}
