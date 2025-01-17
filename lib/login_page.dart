/*import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Örnek giriş bilgileri
  final String _sampleEmail = "admin@example.com";
  final String _samplePassword = "123456";

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == _sampleEmail && password == _samplePassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Başarıyla giriş yapıldı!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hatalı kullanıcı adı veya şifre.")),
      );
    }
  }

  void _navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Giriş Paneli')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-posta",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Giriş Yap"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _navigateToRegisterPage,
              child: Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Örnek giriş bilgileri
  final String _sampleEmail = "admin@example.com";
  final String _samplePassword = "123456";

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == _sampleEmail && password == _samplePassword) {
      // Giriş başarılı
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Başarıyla giriş yapıldı!")),
      );
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      // Giriş başarısız
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hatalı kullanıcı adı veya şifre.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-posta",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Giriş Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart'; // RegisterPage'i import ediyoruz

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Örnek giriş bilgileri
  final String _sampleEmail = "admin@example.com";
  final String _samplePassword = "123456";

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == _sampleEmail && password == _samplePassword) {
      // Giriş başarılı
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Başarıyla giriş yapıldı!")),
      );
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      // Giriş başarısız
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hatalı kullanıcı adı veya şifre.")),
      );
    }
  }

  void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()), // Kayıt sayfasına yönlendiriyoruz
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-posta",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Giriş Yap"),
            ),
            SizedBox(height: 20),
            // Kayıt ol butonu
            TextButton(
              onPressed: _goToRegisterPage,
              child: Text("Hesabınız yok mu? Kayıt Olun"),
            ),
          ],
        ),
      ),
    );
  }
}

