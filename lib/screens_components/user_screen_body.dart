import 'package:cook_it/screens_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserScreenBody extends StatelessWidget {
  String? userName;
  late String password;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<String> getCurrentUserName() async {
    final user = db.collection("users").doc(auth.currentUser!.uid);
    try {
      DocumentSnapshot doc = await user.get();
      final data = doc.data() as Map<String, dynamic>;
      final firstName = data["firstname"];
      final lastName = data["lastname"];
      return "$firstName $lastName";
    } catch (e) {
      print("Error getting document: $e");
      return "Error fetching name"; // You might want to handle this differently.
    }
  }

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int limit = names.length > 2
        ? 2
        : names
            .length; // For names like "John Doe Smith", we take "JD" not "JDS"
    for (var i = 0; i < limit; i++) {
      initials += '${names[i][0]}';
    }
    return initials.toUpperCase();
  }

  Future<String> getCurrentUserNameInitials() async {
    String fullName = await getCurrentUserName();
    return getInitials(fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome",
            style: TextStyle(fontSize: 40.0),
          ),
          SizedBox(height: 20.0),
          FutureBuilder<String>(
            future: getCurrentUserNameInitials(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...'); // or a CircularProgressIndicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircleAvatar(
                  radius: 40.0,
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    snapshot.data!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 20.0),
          FutureBuilder<String>(
            future: getCurrentUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...'); // or a CircularProgressIndicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  snapshot.data!,
                  style: TextStyle(fontSize: 20.0),
                );
              }
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              WoltModalSheet.show<void>(
                context: context,
                pageListBuilder: (BuildContext context) {
                  final textTheme = Theme.of(context).textTheme;

                  return [
                    WoltModalSheetPage.withSingleChild(
                      topBarTitle: Text("Change your password"),
                      isTopBarLayerAlwaysVisible: true,
                      trailingNavBarWidget: IconButton(
                        icon: CircleAvatar(
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          backgroundColor: CupertinoColors.systemGrey6,
                        ),
                        onPressed: Navigator.of(context).pop,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 16.0),
                            Column(
                              children: [
                                TextField(
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter your new password'),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () async {
                                await auth.currentUser!
                                    .updatePassword(password);
                                Navigator.pop(context);
                              },
                              child: Text('change password'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 25.0),
                                backgroundColor: kPrimaryColor,
                                elevation: 5.0,
                                padding: EdgeInsets.symmetric(horizontal: 75.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ];
                },
              );
            },
            child: Text("Change password"),
          )
        ],
      ),
    );
  }
}
