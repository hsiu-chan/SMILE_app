import 'dart:convert';

class AppConfig {
  String apiBaseUrl;
  String apiKey;

  AppConfig({required this.apiBaseUrl, required this.apiKey});

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      apiBaseUrl: json['apiBaseUrl'] ?? '',
      apiKey: json['apiKey'] ?? '',
    );
  }
}
