// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../widgets/chat/messages.dart';
// import '../widgets/chat/new_message.dart';
// import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// class ChatScreen extends StatefulWidget {
//   static const routeName = '/chatScreen';
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     super.initState();

//     final fpm = FirebaseMessaging();
//     fpm.requestNotificationPermissions();
//     fpm.configure(onMessage: (msg) {
//       print(msg);
//       return;
//     }, onLaunch: (msg) {
//       print(msg);
//       return;
//     }, onResume: (msg) {
//       print(msg);
//       return;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20)),
//                   color: Colors.white),
//               margin: EdgeInsets.only(top: 100),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Messages(),
//                     ),
//                     NewMessage()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
