import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_it/screens/main_screen.dart';
import 'package:cook_it/screens_components/rounded_button.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  bool _showSpinner = false;

  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  void registerUser() async {
    if (email == null ||
        password == null ||
        firstname == null ||
        lastname == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Please fill in all fields.',
      );
      return;
    }
    setState(() {
      _showSpinner = true;
    });
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      if (newUser != null) {
        makeUserInUsersDoc();
        Navigator.pushNamed(context, MainScreen.id);
      }
      setState(() {
        _showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message ==
          "The email address is already in use by another account.") {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Email is already in use.',
        );
        setState(() {
          _showSpinner = false;
        });
      } else if (e.message == "Password should be at least 6 characters") {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Password is weak or shorter than 6 characters',
        );
        setState(() {
          _showSpinner = false;
        });
      }
    }
  }

  void makeUserInUsersDoc() async {
    final user = <String, String>{
      "firstname": firstname!,
      "lastname": lastname!,
    };
    final userDoc = db.collection("users").doc(_auth.currentUser!.uid);
    try {
      await userDoc.set(user);
      final favoritedRecipesDoc =
          userDoc.collection("favoritedrecipes").doc("recipes");
      await favoritedRecipesDoc.set({'recipes': []});
    } catch (e) {
      print('Error creating user: $e');
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        firstname = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Firstname',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        lastname = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Lastname',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                color: Colors.blueAccent,
                text: 'Register',
                function: () {
                  registerUser();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
