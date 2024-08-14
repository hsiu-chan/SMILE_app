import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';
import 'package:smile/app/modules/result/result_page.dart';

import 'history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  Future<void> _review() async {
    // 實現 review 功能
    Get.to(() => ResultPage(), arguments: {
      'smile_info': controller.hiveUtil.smileInfoBox
          .get(controller.allRecordKeys.value[controller.selectedIndices.last]),
      'review': true,
    });
    return;
  }

  Future<void> _compare() async {
    // TODO:實現 compare 功能、頁面
    return;
  }

  @override
  Widget build(BuildContext context) {
    // 確保 Controller 只被初始化一次
    final controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryPage'),
        centerTitle: true,
      ),
      body: MainFrame(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                List<String> allRecordKeys = controller.allRecordKeys;

                if (allRecordKeys.isEmpty) {
                  return const Center(child: Text('No history available.'));
                }

                List<Widget> listItems = [];
                for (int index = 0; index < allRecordKeys.length; index++) {
                  bool isSelected = controller.selectedIndices.contains(index);

                  listItems.add(ListTile(
                    title: Text(
                      allRecordKeys[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    tileColor:
                        isSelected ? Get.theme.focusColor : Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Get.theme.highlightColor,
                    onTap: () {
                      controller.toggleSelection(index);
                    },
                  ));
                }

                return ListView(
                  children: listItems,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() => IfOnButton(
                          onPressed: _review,
                          text: "Review",
                          isOn: controller.reviewBtn.value,
                        )),
                  ),
                  SizedBox(width: 16), // 添加間距
                  Expanded(
                    child: Obx(() => IfOnButton(
                          onPressed: _compare,
                          text: "Compare",
                          isOn: controller.compareBtn.value,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IfOnButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOn;

  IfOnButton({required this.text, required this.onPressed, required this.isOn});

  @override
  Widget build(BuildContext context) {
    Color textColor = isOn ? Colors.black : Colors.grey;
    ButtonStyle buttonStyle = ButtonStyle(
      fixedSize: WidgetStateProperty.all<Size>(
        Size(Get.width * 0.4, 85), // 設置寬度和高度
      ),
      backgroundColor: WidgetStateProperty.all<Color>(isOn
          ? Color.fromRGBO(200, 200, 200, 1)
          : Color.fromRGBO(230, 230, 230, 1)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      splashFactory: isOn ? InkRipple.splashFactory : NoSplash.splashFactory,
      overlayColor: isOn
          ? null
          : WidgetStateProperty.all<Color>(Colors.transparent), // 去掉按壓變色
    );

    TextStyle textStyle = TextStyle(
      color: textColor,
      fontSize: 30,
      fontWeight: FontWeight.normal,
    );

    return TextButton(
      child: Center(child: Text(text, style: textStyle)),
      style: buttonStyle,
      onPressed: isOn ? onPressed : () {},
    );
  }
}
