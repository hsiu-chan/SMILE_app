import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> pickAndSaveFile() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // 获取应用程序的临时目录
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // 构建临时文件路径
    String tempFilePath =
        '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // 复制选择的文件到临时路径
    File(pickedFile.path).copy(tempFilePath);
    return tempFilePath;
  } else {
    print('No file selected');
    return null;
  }
}
