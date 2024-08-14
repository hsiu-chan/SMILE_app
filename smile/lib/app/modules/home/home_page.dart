import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/history/history_page.dart';
import 'package:smile/app/modules/login/login_page.dart';
import 'package:smile/app/modules/result/result_page.dart';
import 'package:smile/config.dart';
//import 'package:smile/app/modules/setting/setting_page.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    //dynamic nowState = SizedBox.shrink();

    Future<void> _pickImage() async {
      controller.clear_img();
      await controller.pickAndSaveFile(); //取得圖片路徑
      if (controller.isEmpty_img_path()) {
        return;
      }
      //nowState = Text("請確認");
    }

    Future<void> _sendImage() async {
      if (controller.isEmpty_img_path()) {
        controller.set_alert('no image selected.');
        return;
      }

      controller.set_alert('uploading to $SMILE_API');

      controller.set_loading(true); // 開始轉圈圈

      if (await controller.upload_img() == false) {
        controller.set_loading(false);
        controller.setCheckBox("upload fail");
        return;
      }
      controller.set_loading(false); // 結束轉圈圈

      controller.set_alert('辨識完成');
      print('辨識完成');

      Get.to(() => ResultPage(), arguments: {
        'img': controller.img_path,
        'smile_info': controller.smileInfo
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        //backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            ListTile(
              onTap: () async {
                Navigator.of(context).pop();

                await Future.delayed(Duration.zero);

                Get.to(() => HomePage());
              },
              leading: Icon(
                Icons.home_filled,
                size: 25,
              ),
              title: NormalText('Home'),
            ),
            ListTile(
              onTap: () async {
                await Future.delayed(Duration.zero);
                Get.to(() => HistoryPage());
              },
              leading: Icon(
                Icons.history,
                size: 25,
              ),
              title: NormalText('History'),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 25,
              ),
              title: NormalText('Settings'),
              onTap: () async {
                await Future.delayed(Duration.zero);
                Get.toNamed('/setting');
              },
            ),
          ],
        ),
      ),

      body: Stack(children: <Widget>[
        MainFrame(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 上傳的圖片
              GestureDetector(
                  //TODO: 相機控制
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      borderRadius: BorderRadius.circular(20), // 圓角半徑20
                    ),
                    height: 400,
                    child: Obx(() => controller.isEmpty_img_path()
                        ? const Align(
                            alignment: Alignment.center, child: Text('選擇照片上傳'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20), // 圓角半徑20
                            child: Image.file(
                              File(controller.img_path),
                              fit: BoxFit.fill,
                            ))),
                  )),

              const SizedBox(
                height: 100,
              ),
              TextButton(
                // 確認
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all<Size>(
                    Size(Get.width * 0.8, 85), // 设置宽度和高度
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(200, 200, 200, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: _sendImage,
                child: const Center(
                    child: Text(
                  'CHECK!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                )),
              )
            ],
          ),
        ),
        Obx(() => controller.loading
            ? Container(
                width: Get.width,
                height: Get.height,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                child: Align(
                  alignment: Alignment.center,
                  child: const SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: CircularProgressIndicator()),
                ),
              )
            : SizedBox.shrink()),
        Obx(() => Text(controller.alert)),
      ]),

      //按鈕
      //按鈕
    );
  }
}
