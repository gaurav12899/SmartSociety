import 'package:ChitChat/screens/admin_screens/complaint_details_admin.dart';
import 'package:flutter/material.dart';
import '../../widgets/homepage/template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Complaints extends StatelessWidget {
  final userId;
  Complaints(this.userId);
  @override
  Widget build(BuildContext context) {
    // final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Template(
        userId: userId,
        child: Expanded(
          child: Container(
            color: Colors.white,
            child: StreamBuilder(
                stream: Firestore.instance.collection('complaints').snapshots(),

                // .orderBy('createdAt', descending: true)

                builder: (ctx, complaintDocuments) {
                  if (complaintDocuments.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final complaintDocs = complaintDocuments.data.documents;

                    return ListView.builder(
                        itemCount: complaintDocs.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ComplaintDetailAdmin.routeName,
                                  arguments: {
                                    'userId': userId,
                                    'id': complaintDocs[index]
                                      
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title:
                                        Text(complaintDocs[index]['subject']),
                                    subtitle: Text(DateFormat().format(
                                        (complaintDocs[index]['createdAt']
                                            .toDate()))),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
