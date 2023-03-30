import 'package:flutter/material.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';

import 'login_with.dart';

class LoginAs extends StatefulWidget {
  const LoginAs({Key? key}) : super(key: key);

  @override
  State<LoginAs> createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              LANGUAGE == "ENGLISH" ? 'Login' : "تسجيل الدخول",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
            _buildLoginButton(
                LANGUAGE == "ENGLISH"
                    ? 'Login as Company'
                    : "تسجيل الدخول كشركة",
                Colors.black.withOpacity(0.7),
                LoginWith(
                  isCompany: true,
                )),
            const SizedBox(height: 20.0),
            _buildLoginButton(
                LANGUAGE == "ENGLISH"
                    ? 'Login as Trainee'
                    : "تسجيل الدخول كمتدرب",
                Colors.black.withOpacity(0.7),
                LoginWith()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(String text, Color color, Widget nextPage) {
    return MaterialButton(
      minWidth: 200.0,
      height: 50.0,
      color: color,
      clipBehavior: Clip.hardEdge,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
