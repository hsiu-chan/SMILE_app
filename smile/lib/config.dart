import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

const String API_URL = "http://192.168.0.169:8777";
const String SMILE_API = "$API_URL/api/SmileDetect_upload_json";
const String LOGIN_API = "$API_URL/api/login";
const String LOGOUT_API = "$API_URL/api/logout";

//const String SMILE_API = 'http://148.72.245.225:8777/SmileDetect_upload_mt';
const double MAINFRAME_PADDING = 16;
double MAINFRAME_WIDTH = Get.width - MAINFRAME_PADDING * 2;
