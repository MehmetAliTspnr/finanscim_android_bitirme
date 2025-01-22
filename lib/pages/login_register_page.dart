import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finanscim/service/auth.dart';
import 'package:finanscim/home_page.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogin = true;
  String? errorMessage; // Hata mesajı

  Future<void> createUser() async {
    try {
      // Kullanıcıyı Firebase Auth ile oluştur
      await Auth().createUser(
        email: emailController.text,
        password: passwordController.text,
      );
      // Kayıt işleminden sonra, giriş sayfasına yönlendirme
      setState(() {
        isLogin = true; // Kayıt olduktan sonra login sayfasına aktarılsın
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt başarılı! Şimdi giriş yapabilirsiniz.")),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signIn() async {
    try {
      // Giriş işlemi
      await Auth().signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      // Giriş başarılı olduğunda, ana sayfaya yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child: Image.asset(
              'lib/assets/image/mavi_login.jpg',  // Arka plan resminin yolu
              fit: BoxFit.cover,  // Resmin tüm ekranı kaplamasını sağlar
            ),
          ),
          // Uygulamanın form alanları ve butonlar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.black54, // Koyu gri renk
                      fontWeight: FontWeight.bold, // Kalın yazı
                    ),
                    filled: true, // Arka planın dolmasını sağlar
                    fillColor: Colors.lightBlue.withValues(alpha:205 ), // Opaklık arttırıldı
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black, width: 2), // Koyu kenar rengi
                    ),
                  ),
                ),
                const SizedBox(height: 10), // İki kutucuk arasında boşluk bırakma
                TextField(
                  controller: passwordController,
                  obscureText: true, // Şifrenin görünmemesi için ekleme ekstra güvenlik+
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black54, // Koyu gri renk
                      fontWeight: FontWeight.bold, // Kalın yazı
                    ),
                    filled: true, // Arka planın dolmasını sağlar
                    fillColor: Colors.lightBlue.withValues(alpha: 205), // Opaklık arttırıldı
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black, width: 2), // Koyu kenar rengi
                    ),
                  ),
                ),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Set the font weight to bold
                      color: Colors.black, // Optional: Set the color of the error message to red
                      fontSize: 14, // Set the font size to 18 (or any value you prefer)
                    ),
                  ),
                const SizedBox(height: 20), // İki kutucuk arasında boşluk bırakıldı
                ElevatedButton(
                  onPressed: () {
                    if (isLogin) {
                      signIn();
                    } else {
                      createUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Butonun arka plan rengini mavi yapar
                    foregroundColor: Colors.white, // Buton üzerindeki metni beyaz yapar
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 75), // Buton boyutlandırması
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Buton köşelerini yuvarlatır
                    ),
                  ),
                  child: isLogin ? const Text("Login") : const Text("Register"),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20), // Adjust the value to move the text down
                    child: const Text(
                      "Hesabınız Yok mu? Kayıt Ol!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Kalın yazı
                        color: Colors.white54, // Koyu siyah renk
                        fontSize: 16, // Yazı boyutu
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
