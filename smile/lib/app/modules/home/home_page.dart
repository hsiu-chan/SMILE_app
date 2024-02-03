import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    dynamic nowState = SizedBox.shrink();

    Future<void> _pickImage() async {
      controller.clear_img();
      await controller.pickAndSaveFile(); //取得圖片路徑
      if (controller.isEmpty_img_path()) {
        return;
      }
      nowState = Text("請確認");
    }

    Future<void> _sendImage() async {
      controller.set_resultImage(Align(
        alignment: Alignment.center,
        child: SizedBox(
            width: 100.0, height: 100.0, child: CircularProgressIndicator()),
      ));

      await controller.upload_img();

      try {
        controller.set_resultImage(
            Image.file(File(controller.rt_img_path), fit: BoxFit.contain));
        nowState = Text('辨識完成');
      } catch (error) {
        controller.set_alert('Error sending image: $error');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            SizedBox(
              height: 70,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
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

      body: Stack(children: <Widget>[
        Obx(() => Text(controller.alert)),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 上傳的圖片
              Container(
                height: 400,
                child: Obx(() => controller.isEmpty_img_path()
                    ? const Align(
                        alignment: Alignment.center, child: Text('選擇照片上傳'))
                    : Image.file(
                        File(controller.img_path!),
                        fit: BoxFit.contain,
                      )),
              ),
              Container(height: 200, child: Obx(() => controller.resultImage)),
            ],
          ),
        ))
      ]),

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
