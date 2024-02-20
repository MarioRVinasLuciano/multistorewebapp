import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:multi_store_web/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid ? FirebaseOptions(

        apiKey: "AIzaSyBcz8trXtIwOUXRHi3viLuQQ0wpIylQB-I",
        projectId: "multi-store-app-5d118",
        storageBucket: "multi-store-app-5d118.appspot.com",
        messagingSenderId: "973245083840",
        appId: "1:973245083840:web:1826fb094e49711bbb7d25",

    ): null
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Multi-store Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen()
    );
  }
}