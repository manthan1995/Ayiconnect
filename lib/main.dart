import 'package:flutter/material.dart';
import 'package:profile_demo/constant/custom_theme.dart';
import 'package:profile_demo/model/user_model.dart';

import 'view/0.0.profile_setup_screen.dart';

UserModel userInfo = getDefaultUserInfo;
void main() {
  runApp(const ProfileDemoApp());
}

class ProfileDemoApp extends StatelessWidget {
  const ProfileDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Demo',
      theme: CustomAppTheme.lightTheme,
      home: const ProfileSetupScreen(),
    );
  }
}
