import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
 
  @override
  Widget build(BuildContext context) {
  final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Template(
        userId: userId,
        isProfilePage: true,
        child: RaisedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context)
                    .pushReplacementNamed('/');
        },
        ),
      ),
    );
  }
}
