import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert' as cvt;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'; //請求權限
import 'package:image/image.dart' as img;

import 'package:smile/controller/smile.dart';

import 'package:smile/get_config.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:smile/controller/img_tool.dart';

AppConfig globalConfig = AppConfig(apiBaseUrl: '', apiKey: '');

Future<void> loadConfig() async {
  try {
    File configFile = File('config.json');
    String contents = await configFile.readAsString();
    Map<String, dynamic> configMap = jsonDecode(contents);
    globalConfig = AppConfig.fromJson(configMap);
  } catch (e) {
    print('Error loading config: $e');
  }
}

void main() {
  loadConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //初始框架
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //螢幕大小

    Orientation orientation = MediaQuery.of(context).orientation; //螢幕方向

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter1 Demo Home Page'), //動態部分
    );
  }
}

class MyHomePage extends StatefulWidget {
  //動態部分
  const MyHomePage({super.key, required this.title}); //Class 初始化

  final String title;
  //final 宣告的 property 是在專案執行（run time）階段的常數。
  //const 宣告的 property 是在專案編譯（compile time）階段的常數。

  @override //重新定義
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? img_path;
  Smile smile = Smile.empty();
  dynamic nowState = SizedBox.shrink();
  dynamic resultImage = SizedBox.shrink();

  @override
  void initState() {
    super.initState();
    _checkPermission();
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

  Future<void> _pickImage() async {
    img_path = await pickAndSaveFile(); //取得圖片路徑
    smile = Smile(img_path!);
    setState(() {
      nowState = Text("請確認");
      resultImage = null;
    });
  }

  Future<void> _sendImage() async {
    setState(() {
      // 轉圈圈等待
      resultImage = Align(
        alignment: Alignment.center,
        child: SizedBox(
            width: 100.0, height: 100.0, child: CircularProgressIndicator()),
      );
    });
    await smile.send_multipart();
    setState(() {
      nowState = Text('辨識完成');

      try {
        resultImage = Image.file(File(smile.result_path!), fit: BoxFit.contain);
      } catch (error) {
        resultImage = Text('Error sending image: $error');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), //如何傳遞title？
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            SizedBox(
              height: 70,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),

      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 上傳的圖片
            Container(
              height: 400,
              child: img_path == null
                  ? const Align(
                      alignment: Alignment.center, child: Text('選擇照片上傳'))
                  : Image.file(
                      File(img_path!),
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(height: 50, child: nowState),
            Container(
              height: 200,
              child: resultImage,
            ),
          ],
        ),
      )),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.red,
            splashColor: Color.fromARGB(150, 255, 0, 0),
            onPressed: _pickImage,
            tooltip: 'PickImage',
            child: const Icon(Icons.image),
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            splashColor: Color.fromARGB(150, 255, 0, 0),
            onPressed: _sendImage,
            tooltip: 'SendImage',
            child: const Icon(Icons.check),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //按鈕
      //按鈕
    );
  }
}
