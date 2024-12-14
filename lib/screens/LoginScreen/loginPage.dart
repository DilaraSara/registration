import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/screens/LoginScreen/signupPage.dart';
import 'package:registration/screens/LoginScreen/verificationPasswordFields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Animation/FadeAnimation.dart';
import '../../providers/auth_provider.dart';
import '../home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _pageLogin = true;
  void _togglePage(bool _switchme) {
    setState(() {
      _pageLogin = _switchme;
    });
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-posta'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Şifre'),
              ),
              LoginDecoration(),
              FadeAnimation(
                0.5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  ],
                ),
              ),
              _pageLogin
                  ? Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    VerificationFields(),

                    SizedBox(height: 10),
                    LoginButton(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _togglePage(false);
                      },
                      child: Text(
                        "Hesabınız yok mu? Kayıt Ol!",
                        style: TextStyle(
                          color: Color.fromRGBO(113, 148, 192, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : SignupPage(),
            ],
          ),
        ),
      ),
    );
  }
}
class LoginDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            child: FadeAnimation(
              1.6,
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.5,
      Container(
        height: 50,
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Color.fromRGBO(113, 148, 192, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            String enteredEmail = _emailController.text;
            String enteredPassword = _passwordController.text;

            try {
              // Firebase Auth üzerinden giriş yapma
              await Provider.of<AuthProvider>(context, listen: false)
                  .login(enteredEmail, enteredPassword);

              // SharedPreferences'ten kullanıcı adı alma
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String userName = prefs.getString('userName') ?? 'Kullanıcı adı bulunamadı';

              // Ana sayfaya yönlendirme
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userName: userName, email: enteredEmail),
                ),
              );
            } catch (e) {
              // Hata durumunda kullanıcıya bilgi verme
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },

          child: Center(
            child: Text(
              "Oturum Aç",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


