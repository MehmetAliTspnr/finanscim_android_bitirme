import 'package:finanscim/pages/login_register_page.dart';
import 'package:flutter/material.dart';
//import 'home_page.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';//bu ikisi firebase importu
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanscım',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginRegisterPage(), // Başlangıç ekranını LoginPage olarak belirledik
    );
  }
}
