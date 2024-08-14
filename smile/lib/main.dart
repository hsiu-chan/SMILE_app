import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';

import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SmileInfoAdapter()); // 註冊 SmileInfoAdapter

  await HiveUtil.install(); // 在這裡初始化 HiveUtil

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
          //primaryColor: Colors.blue, // 設定主色調
          focusColor: Colors.amber,
          highlightColor: Color.fromARGB(255, 253, 231, 153)
          // textTheme: GoogleFonts.latoTextTheme(), // 若需要，可設定 Google 字體
          ),
    ),
  );
}
