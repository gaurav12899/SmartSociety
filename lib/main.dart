import 'package:ChitChat/screens/admin_screens/add_vendor.dart';
import 'package:ChitChat/screens/admin_screens/complaint_details_admin.dart';
import 'package:ChitChat/screens/admin_screens/create_poll.dart';
import 'package:ChitChat/screens/complaints/complaint_detail.dart';
import 'package:ChitChat/screens/my_home_page.dart';
import 'package:ChitChat/screens/splash_screen.dart';
import 'package:ChitChat/screens/tab_screen.dart';
import 'package:ChitChat/screens/vendor_list_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/complaints/complaint_screen.dart';
import './screens/events_screen.dart';
import './screens/poll_screen.dart';
import './screens/help_screen.dart';
import './screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/admin_screens/vendorsAdmin.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get _getUserId async {
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Smart Society",
        theme: ThemeData(
          primaryColor: Colors.blueGrey.shade800,
          accentColor: Colors.blueGrey,
          canvasColor: Colors.blueGrey.shade200,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.yellow.shade600,
            textTheme: ButtonTextTheme.primary,
            minWidth: 150,
            height: 50, 
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              
            ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  // fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: StreamBuilder(
          builder: (ctx, streamSnapshotOne) {
            if (streamSnapshotOne.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (streamSnapshotOne.hasData) {
              return FutureBuilder(
                  future: _getUserId,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .document(snapshot.data)
                              .snapshots(),
                          builder: (context, streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              if (streamSnapshot.data['userType'] == 'admin') {
                                return TabScreen(snapshot.data.toString());
                              } else {
                                return MyHomePage(snapshot.data.toString());
                              } 
                            } else {
                              return Scaffold(body:Center(child: CircularProgressIndicator(),));
                            }
                          });
                    } else {
                      return Container();
                    }
                  });
            } else {
              return AuthScreen();
            }
          },
          stream: FirebaseAuth.instance.onAuthStateChanged,
        ),
        routes: {
          Profile.routeName: (ctx) => Profile(),
          EventsScreen.routeName: (ctx) => EventsScreen(),
          ComplaintScreen.routeName: (ctx) => ComplaintScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
          PollScreen.routeName: (ctx) => PollScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          ComplaintDetail.routeName:(ctx)=>ComplaintDetail(),
          ComplaintDetailAdmin.routeName:(ctx)=>ComplaintDetail(),
          VendorListScreen.routeName:(ctx)=>VendorListScreen(),
          AddVendor.routeName:(ctx)=>AddVendor(),
          CreatePoll.routeName:(ctx)=>CreatePoll()
        });
  }
}
