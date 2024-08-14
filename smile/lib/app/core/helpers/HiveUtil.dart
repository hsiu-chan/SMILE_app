import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smile/app/modules/smile/smile.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';

/// Hive db 操作
class HiveUtil {
  /// 實例
  static HiveUtil? instance;

  /// Box 們
  late Box userBox;
  late Box<SmileInfo> smileInfoBox;

  /// 初始化，main.dart調用
  static Future<void> install() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    //Hive.init('userbox');
  }

  /// 初始化 Box
  static Future<HiveUtil> getInstance() async {
    if (instance == null) {
      //instance還沒初始化
      instance = HiveUtil();
      await Hive.initFlutter();

      /// 标签
      instance!.userBox = await Hive.openBox('userbox');
      instance!.smileInfoBox = await Hive.openBox<SmileInfo>("smileInfoBox");
    }

    return instance!;
  }

  dynamic get(String key) {
    return userBox.get(key);
  }
}
