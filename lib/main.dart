import 'package:flutter/material.dart';
import 'package:project/screens/home/home_content.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/home/profile_content.dart';
import 'package:project/screens/home/work_activity_content.dart';
import 'package:project/screens/signin.dart';
import 'package:project/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SigninScreen(),
    );
  }
}
