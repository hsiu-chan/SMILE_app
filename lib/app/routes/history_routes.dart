import 'package:get/get.dart';

import '../modules/history/history_binding.dart';
import '../modules/history/history_page.dart';

class HistoryRoutes {
  HistoryRoutes._();

  static const history = '/history';

  static final routes = [
    GetPage(
      name: history,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
  ];
}
