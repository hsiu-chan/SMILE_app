import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Smile {
  //String base64Image = "";
  //String ext = "";
  //String base64Result = '';
  String? input_path;
  String? result_path = null;
  late Uint8List _imageBytes;

  final Uri API_ENDPOINT =
      Uri.parse('http://127.0.0.1:8888/SmileDetect_upload_mt');

  Smile(this.input_path);
  Smile.empty() {}

  Future<void> send_multipart() async {
    if (input_path == null) {
      return;
    }
    var request = http.MultipartRequest('POST', API_ENDPOINT);
    var file = await http.MultipartFile.fromPath('file', input_path!);
    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        _imageBytes = await response.stream.toBytes();

        // 获取应用程序的临时目录
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;

        // 构建临时文件路径
        result_path = '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpeg';

        // 将图像字节写入临时文件
        await File(result_path!).writeAsBytes(_imageBytes);

        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  /*Future<void> send_base64() async {
    if (base64Image.isNotEmpty) {
      var response = await http.post(
        API_ENDPOINT,
        body: jsonEncode({'image': base64Image}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // 解析並處理數據
        Map<String, dynamic> data = json.decode(response.body);

        base64Result = data['result'];
      } else {
        // 處理錯誤
      }
    }
  }*/
}
