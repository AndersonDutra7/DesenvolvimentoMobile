import 'package:flutter/material.dart';
import 'package:need_food/views/home_page.dart';
import 'package:need_food/views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Correção aqui

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Need Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
