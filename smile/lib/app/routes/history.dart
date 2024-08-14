import 'package:get/get.dart';
import 'package:smile/app/modules/history/history_binding.dart';
import 'package:smile/app/modules/history/history_page.dart';

class HistoryRoutes {
  HistoryRoutes._();

  static const setting = '/setting';

  static final routes = [
    GetPage(
      name: setting,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
  ];
}
