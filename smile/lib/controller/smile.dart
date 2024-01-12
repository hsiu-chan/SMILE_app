import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Smile {
  String base64Image = "";
  String ext = "";
  String base64Result = '';

  final Uri API_ENDPOINT =
      Uri.parse('http://127.0.0.1:8888/SmileDetect_upload');

  Smile(this.base64Image);
  Smile.empty() {
    base64Image = '';
    ext = '';
  }

  Future<void> send() async {
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
  }
}
