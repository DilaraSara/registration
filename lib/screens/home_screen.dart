import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen/loginPage.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final String email;

  HomeScreen({required this.userName, required this.email});

  // Çıkış yapma fonksiyonu
  void logout(BuildContext context) async {
    // SharedPreferences'teki kullanıcı bilgilerini temizliyoruz
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userName');

    // Çıkış yapıldığında LoginPage'e yönlendiriyoruz
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hoşgeldiniz, $userName")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hoşgeldiniz!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Ad: $userName"),
            Text("E-posta: $email"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => logout(context),
              child: Text("Çıkış Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
