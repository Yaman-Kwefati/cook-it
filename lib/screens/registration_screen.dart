import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cook_it/screens/home_screen.dart';
import 'package:cook_it/screens_components/rounded_button.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
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
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                text: 'Register',
                function: () async {
                  Navigator.pushNamed(context, HomeScreen.id);
                  // setState(() {
                  //   _showSpinner = true;
                  // });
                  // try {
                  //   final newUser = await _auth.createUserWithEmailAndPassword(
                  //       email: email, password: password);
                  //   if (newUser != null) {
                  //     Navigator.pushNamed(context, ChatScreen.id);
                  //   }
                  //   setState(() {
                  //     _showSpinner = false;
                  //   });
                  // } catch (e) {
                  //   print(e);
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
