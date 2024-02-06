import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile/app/core/widgets/main_frame.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
        centerTitle: true,
      ),
      body: MainFrame(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // 登录逻辑
                print('Login button pressed');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
