import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cook_it/screens/login_screen.dart';
import 'package:cook_it/screens/registration_screen.dart';
import 'package:cook_it/screens_components/rounded_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 90.0,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Hero(
                    tag: 'text',
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'CookIt',
                          textStyle: const TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Log in',
                function: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                color: Colors.blueAccent,
                text: 'Register',
                function: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
