import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cook_it/screens/home_screen.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../screens_components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool _showSpinner = false;
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
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                  function: () {
                    // setState(() {
                    //   _showSpinner = true;
                    // });
                    Navigator.pushNamed(context, HomeScreen.id);
                    // loginCurrentUser();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
