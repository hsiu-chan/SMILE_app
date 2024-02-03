import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController.
  RxString _img_path = ''.obs;
  String get img_path => _img_path.value;

  RxString _rt_img_path = ''.obs;
  String get rt_img_path => _rt_img_path.value;

  RxString _alert = ''.obs;
  String get alert => _alert.value;

  Rxn<Widget> _resultImage = Rxn<Widget>();
  Widget get resultImage => _resultImage.value ?? SizedBox.shrink();

  void set_alert(String? a) {
    _alert.value = a ?? '';
    update();
    Future.delayed(Duration(seconds: 3), () {
      _alert.value = '';
    });
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

  Future<void> pickAndSaveFile() async {
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
  }

  final Uri API_ENDPOINT =
      Uri.parse('http://127.0.0.1:8888/SmileDetect_upload_mt');
  Future<void> upload_img() async {
    if (isEmpty_img_path()) {
      return;
    }
    var request = http.MultipartRequest('POST', API_ENDPOINT);
    var file = await http.MultipartFile.fromPath('file', _img_path.value);
    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        Uint8List _imageBytes = await response.stream.toBytes();

        // 获取应用程序的临时目录
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;

        // 构建临时文件路径
        _rt_img_path.value =
            '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpeg';

        // 将图像字节写入临时文件
        await File(rt_img_path).writeAsBytes(_imageBytes);

        set_alert('File uploaded successfully');
      } else {
        set_alert('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (error) {
      set_alert('Error uploading file: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkPermission();
  }

  @override
  void onReady() {
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
