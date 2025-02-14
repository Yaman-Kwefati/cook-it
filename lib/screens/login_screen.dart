import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cook_it/screens/main_screen.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../screens_components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool _showSpinner = false;

  void loginCurrentUser() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential != null) {
        Navigator.pushNamed(context, MainScreen.id);
      }
      setState(() {
        _showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.message != null &&
          e.message!.contains("INVALID_LOGIN_CREDENTIALS")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Email or Password are wrong...',
        );
        setState(() {
          _showSpinner = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'text',
                  child: TextLiquidFill(
                    text: 'CookIt',
                    waveColor: Colors.black,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                  function: () {
                    loginCurrentUser();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
