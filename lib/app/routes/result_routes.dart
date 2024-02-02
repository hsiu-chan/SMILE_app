import 'package:get/get.dart';

import '../modules/result/result_binding.dart';
import '../modules/result/result_page.dart';

class ResultRoutes {
  ResultRoutes._();

  static const result = '/result';

  static final routes = [
    GetPage(
      name: result,
      page: () => const ResultPage(),
      binding: ResultBinding(),
    ),
  ];
}
