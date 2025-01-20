/*import 'package:finanscim/pages/login_register_page.dart';
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
*/
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore importu
import 'firebase_options.dart';
import 'package:finanscim/pages/login_register_page.dart'; // LoginRegisterPage ekranı

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlatıyoruz
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
      home: LoginRegisterPage(), // Başlangıç ekranı
    );
  }
}

// Firestore'a veri eklemek için örnek bir fonksiyon
Future<void> addTransactionToFirestore(double amount, String type, DateTime date) async {
  try {
    await FirebaseFirestore.instance.collection('transactions').add({
      'amount': amount,  // Miktar
      'date': date,      // Tarih
      'type': type,      // Gelir veya gider tipi
    });
    print('Veri başarıyla Firestore\'a eklendi!');
  } catch (e) {
    print('Firestore\'a veri eklerken bir hata oluştu: $e');
  }
}
