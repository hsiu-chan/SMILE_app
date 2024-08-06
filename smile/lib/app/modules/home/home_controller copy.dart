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

import 'package:smile/config.dart';

class HomeController_mt extends GetxController {
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

  dynamic smile_info;

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

      // 构建临时文件路径
      String tempFilePath =
          '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

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

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // 啥都沒有
        if (response.headers['content-type']! == 'application/json') {
          setCheckBox('Face not found');

          return false;
        }

        // 找到臉了
        var boundary = response.headers['content-type']!
            .split('boundary=')[1]; // 取得 http body 的分界

        var parts = MimeMultipartTransformer(boundary)
            .bind(response.stream); //分出每一 part

        await for (var part in parts) {
          // 解析 contentDisposition
          var contentDisposition = part.headers['content-disposition'] ?? '';
          List<String> dispositions = contentDisposition.split(';');

          // 取得 multi 的 name=
          String name = '';
          for (var disposition in dispositions) {
            disposition = disposition.trim();
            if (disposition.startsWith('name=')) {
              name =
                  disposition.substring('name='.length + 1).replaceAll('"', '');
            }
          }

          // contentType
          var contentType = part.headers['content-type'] ?? '';

          // 根據 name 處理 multipart
          switch (name) {
            // 微笑照片
            case 'image':
              // bit  資料
              var _data = await part.fold<List<int>>(
                  [], (prev, element) => prev..addAll(element));

              // 取得臨時目錄
              Directory tempDir = await getTemporaryDirectory();
              String tempPath = tempDir.path;

              // // 構建圖片路徑
              String _ext = contentType.split('/')[1];
              _rt_img_path.value =
                  '$tempPath/${DateTime.now().millisecondsSinceEpoch}.$_ext';

              // 寫入圖片
              await File(rt_img_path).writeAsBytes(_data);

            case 'info':
              assert(contentType.contains('application/json'));
              // JSON -> string
              var jsonString = await part.transform(utf8.decoder).join();
              // 解析JSON
              smile_info = json.decode(jsonString);
              print(smile_info);

            case 'error':
              set_alert(await part.transform(utf8.decoder).join());

            default:
              setCheckBox('$name not suppport');
              print('$name not suppport');
          }
        }

        set_alert('File uploaded successfully');
        return true;
      } else {
        //set_alert('Failed to upload file. Status code: ${response.statusCode}');
        setCheckBox('No smile');
      }
    } catch (error) {
      setCheckBox('Error uploading file: $error');
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
