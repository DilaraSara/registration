import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      // Firebase ile giriş yap
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Giriş başarılıysa
      _user = userCredential.user;

      // Kullanıcı bilgilerini SharedPreferences'e kaydet
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', email);
      prefs.setString('userName', _user?.displayName ?? 'Kullanıcı adı bulunamadı');

      notifyListeners();
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      // Firebase ile yeni kullanıcı kaydı
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Yeni kullanıcı bilgilerini kaydet
      _user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', email);
      prefs.setString('userName', _user?.displayName ?? 'Kullanıcı adı bulunamadı');

      notifyListeners();
    } catch (e) {
      throw Exception('Kayıt başarısız: $e');
    }
  }
}
