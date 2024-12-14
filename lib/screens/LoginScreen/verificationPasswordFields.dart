import 'package:flutter/material.dart';
import '../../Animation/FadeAnimation.dart';

class VerificationFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.5,
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
              child: TextField(
                cursorColor: Colors.purpleAccent,
                style: TextStyle(color: Color.fromRGBO(113, 148, 192, 1)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "E-Posta ya da Telefon Numarası",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: PasswordField(),
            )
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}
class _PasswordFieldState extends State<PasswordField> {
  bool _ishidden = true;
  void _toggleVisibility() {
    setState(() {
      _ishidden = !_ishidden;
    },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: _ishidden ? true : false,
        style: TextStyle(color: Color.fromRGBO(113, 148, 192, 1)),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_ishidden ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleVisibility,
          ),
          border: InputBorder.none,
          hintText: "Şifre",
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}