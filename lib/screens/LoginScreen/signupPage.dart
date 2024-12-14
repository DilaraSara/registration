import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/screens/LoginScreen/verificationPasswordFields.dart';
import '../../Animation/FadeAnimation.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _pageSignup = true;

  void _togglePage(bool _switchme) {
    setState(() {
      _pageSignup = _switchme;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),

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
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(113, 148, 192, .2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[100] ?? Colors.grey,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        cursorColor: Colors.purpleAccent,
                        style: TextStyle(
                          color: Color.fromRGBO(113, 148, 192, 1),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "İsim",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                      TextField(
                        cursorColor: Colors.purpleAccent,
                        style: TextStyle(
                          color: Color.fromRGBO(113, 148, 192, 1),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Soyisim",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.purpleAccent,
                        style: TextStyle(
                          color: Color.fromRGBO(113, 148, 192, 1),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "E-Posta",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                      PasswordField(),
                      PasswordField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SignupButton(
            onPressed: () async {
              String email = _emailController.text;
              String password = _passwordController.text;

              try {
                // Firebase Authentication ile kullanıcı kaydı
                UserCredential userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                // Kullanıcı kaydı başarılı
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Kullanıcı başarıyla kaydedildi!"),
                ));
              } catch (e) {
                // Hata durumunda mesaj gösterme
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Hata: $e"),
                ));
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // LoginPage'e yönlendirir
              );

            },
            child: Text(
              "Zaten Hesabınız Var mı? Giriş Yap!",
              style: TextStyle(
                color: Color.fromRGBO(113, 148, 192, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

  }
}



class SignupButton extends StatelessWidget {
  final VoidCallback onPressed;

  SignupButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.5,
      Container(
        height: 50,
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor: Color.fromRGBO(113, 148, 192, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: Center(
            child: Text(
              "SignUp",
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

