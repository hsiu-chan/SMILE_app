import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:smile/app/modules/smile/smile.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';

import 'package:smile/config.dart';

import 'package:hive/hive.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxString _img_path = ''.obs;
  String get img_path => _img_path.value;

  RxString _rt_img_path = ''.obs;
  String get rt_img_path => _rt_img_path.value;

  RxString _alert = ''.obs;
  String get alert => _alert.value;

  Rxn<Widget> _resultImage = Rxn<Widget>();
  Widget get resultImage => _resultImage.value ?? SizedBox.shrink();

  RxBool _loading = false.obs;
  bool get loading => _loading.value;

  late SmileInfo smileInfo;

  void set_alert(String? a) {
    return;
    _alert.value = a ?? '';
    update();
    Future.delayed(Duration(seconds: 3), () {
      _alert.value = '';
    });
  }

  void setCheckBox(String? message) {
    Get.defaultDialog(
      title: '提示',
      middleText: message ?? '無訊息',
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('確認'),
      ),
    );
  }

  void set_resultImage(Widget? w) {
    _resultImage.value = w;
  }

  bool isEmpty_img_path() {
    return _img_path.value == '';
  }

  void clear_img() {
    _img_path.value = '';
    _rt_img_path.value = '';
    _resultImage.value = null;
    update();
  }

  void set_loading(bool x) {
    _loading.value = x;
  }

  Future<void> pickAndSaveFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        set_alert('No file selected.');
        return;
      }

      // 获取应用程序的临时目录
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String img_type = pickedFile.path.split('.').last;

      // 构建临时文件路径
      String tempFilePath =
          '$tempPath/${DateTime.now().millisecondsSinceEpoch}.${img_type}';

      // 复制选择的文件到临时路径
      File(pickedFile.path).copy(tempFilePath);
      _img_path.value = tempFilePath;
    } catch (e) {
      set_alert('$e');
    }
  }

  Future<bool> upload_img() async {
    final Uri API_ENDPOINT = Uri.parse(SMILE_API);

    // 檢查 img 路徑
    if (isEmpty_img_path()) {
      print('img_path_isEmpty');
      return false;
    }

    // http 請求
    var request = http.MultipartRequest('POST', API_ENDPOINT);
    var file = await http.MultipartFile.fromPath('file', _img_path.value);
    request.files.add(file); // 添加圖片

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> smileInfo_json = jsonDecode(responseBody);
      smileInfo_json["path"] = _img_path.value;
      smileInfo = SmileInfo.fromJson(smileInfo_json);

      // 辨識結果存檔
      /*
      final app_dir = await getApplicationDocumentsDirectory();

      final String save_path = "${app_dir.path}/${img_path.split('/').last}";

      File(img_path).copy(save_path);
      smileInfo_json["path"] = save_path;

      smileInfo = SmileInfo.fromJson(smileInfo_json);

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      //await hiveUtil.smileInfoBox.put(formattedDate, smileInfo);*/

      return true;
    } else {
      //set_alert('Failed to upload file. Status code: ${response.statusCode}');
      setCheckBox('No smile');
    }

    return false;
  }

  @override
  void onInit() {
    super.onInit();

    //_checkPermission();
  }

  @override
  void onReady() {
    print('ready');
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // 如果权限被拒绝，请求权限
      await Permission.camera.request();
      // 检查权限状态并处理相应逻辑
      status = await Permission.camera.status;
      if (status.isGranted) {
        // 权限已被授予
        print("Camera permission granted");
      } else {
        // 用户仍然拒绝权限
        print("Camera permission denied");
      }
    } else if (status.isGranted) {
      // 权限已被授予
      print("Camera permission granted");
    }
  }
}
