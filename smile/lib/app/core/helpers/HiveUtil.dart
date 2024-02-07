import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Hive db 操作
class HiveUtil {
  /// 實例
  static HiveUtil? instance;

  /// Box 們
  late Box userBox;

  /// 初始化，main.dart調用
  static Future<void> install() async {
    /// 初始化数据库地址
    Directory document = await getApplicationDocumentsDirectory();

    /// 注册自定义对象（实体）
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
    }

    return instance!;
  }
}
