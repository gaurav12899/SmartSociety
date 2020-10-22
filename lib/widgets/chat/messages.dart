import './message_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final chatDocument = chatSnapshot.data.documents;
                  return ListView.builder(
                      reverse: true,
                      itemCount: chatDocument.length,
                      itemBuilder: (ctx, index) {
                        return MessageBubble(
                          chatDocument[index]['text'],
                          chatDocument[index]['userId'] ==
                              userSnapshot.data.uid,
                          chatDocument[index]['username'],
                          chatDocument[index]['image_url'],
                          key: ValueKey(chatDocument[index].documentID),
                        );
                      });
                }
              });
        });
  }
}
