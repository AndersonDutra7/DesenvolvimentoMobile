import 'package:flutter/material.dart';
import 'package:need_food/views/home_page.dart';
import 'package:need_food/views/login_page.dart';

void main() {
  runApp(const NeedFoodApp());
}

class NeedFoodApp extends StatelessWidget {
  const NeedFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeedFood',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
