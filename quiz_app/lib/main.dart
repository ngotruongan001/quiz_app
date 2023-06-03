import 'package:flutter/material.dart';
import 'package:quiz_app/modules/home/home_page.dart';
import 'package:quiz_app/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightThem,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

