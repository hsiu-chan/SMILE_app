import 'dart:convert';
import 'package:http/http.dart' as http;

class _Smile {
  String base64Image = "";
  final Uri API_ENDPOINT = Uri.parse('YOUR_API_ENDPOINT');

  _Smile(this.base64Image);

  Future<void> _send() async {
    if (base64Image.isNotEmpty) {
      final response = await http.post(
        API_ENDPOINT,
        body: jsonEncode({'image': base64Image}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }
}
