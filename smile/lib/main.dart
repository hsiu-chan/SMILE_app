import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';

import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //確認Widgets 初始化
  await Hive.initFlutter(); //Hive 初始化

  await HiveUtil.install();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
