import 'home_routes.dart';
import 'result_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';

  static final routes = [
    ...HomeRoutes.routes,
		...ResultRoutes.routes,
  ];
}
