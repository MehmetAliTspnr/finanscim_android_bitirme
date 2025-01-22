import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore importu
import 'firebase_options.dart';
import 'package:finanscim/pages/login_register_page.dart'; // LoginRegisterPage ekranı

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//Firebase başlatılmadan önce gerekli tüm Flutter
  // bileşenlerinin başlatılmasını sağlar.

  // Firebase'i başlatma
  await Firebase.initializeApp(  //await: asenkron
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanscım',
      debugShowCheckedModeBanner: false,//debug yazısını kaldırıldı.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginRegisterPage(), // Başlangıç ekranı
    );
  }
}

// Firestore'a veri ekleme örnegi*
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
