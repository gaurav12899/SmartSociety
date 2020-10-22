import 'package:ChitChat/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Template extends StatelessWidget {
  final Widget child;
  final isProfilePage;
  final String userId;
  // final userId;
  Template({this.userId, this.child, this.isProfilePage = false});

//   @override
//   _TemplateState createState() => _TemplateState();
// }

// class _TemplateState extends State<Template> {
  void profilePage(BuildContext context) {
    Navigator.of(context).pushNamed(Profile.routeName, arguments: userId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Column(children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                leading: Chip(
                    label: Text(
                  "A-34",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                title: (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(child: CircularProgressIndicator())
                    : Chip(
                        label: Text(snapshot.data['username'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                trailing: GestureDetector(
                  onTap: () {
                    isProfilePage ? null : profilePage(context);
                  },
                  child: (snapshot.connectionState == ConnectionState.waiting)
                      ? null
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data['image_url'],
                          ),
                          radius: 30,
                        ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            if (child != null) child,

                            // NewMessage()
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ]);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
