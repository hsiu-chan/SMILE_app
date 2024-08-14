import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';
import 'package:smile/app/core/helpers/HiveUtil.dart';
import 'package:smile/app/modules/smile/smile_info_adapter.dart';

class HistoryController extends GetxController {
  late HiveUtil hiveUtil;
  RxList<String> allRecordKeys = <String>[].obs;
  RxBool reviewBtn = false.obs;
  RxBool compareBtn = false.obs;
  RxInt slectedNum = 0.obs;
  // 這裡用來記錄選擇的項目
  RxSet<int> _selectedIndices = <int>{}.obs;
  Set<int> get selectedIndices => _selectedIndices.value;

  Future<void> getAllSmileInfoRecords() async {
    // 獲取 SmileInfoBox
    Box<SmileInfo> smileInfoBox = hiveUtil.smileInfoBox;

    // 取得所有 keys
    List<dynamic> keys = smileInfoBox.keys.toList();

    // 確保 keys 是 String 類型並轉換
    List<String> stringKeys = keys.cast<String>();

    // 更新 allRecordKeys
    allRecordKeys.value = stringKeys;
  }

  void toggleSelection(int index) {
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
      slectedNum.value--;
      print("切換");
    } else {
      if (slectedNum.value < 2) {
        _selectedIndices.add(index);
        slectedNum.value++;
        print("切換");
      }
    }
    switch (slectedNum.value) {
      case 0:
        reviewBtn.value = false;
        compareBtn.value = false;
      case 1:
        reviewBtn.value = true;
        compareBtn.value = false;
      case 2:
        reviewBtn.value = false;
        compareBtn.value = true;
    }
    _selectedIndices.refresh();
  }

  @override
  Future<void> onInit() async {
    hiveUtil = await HiveUtil.getInstance();
    await getAllSmileInfoRecords();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
