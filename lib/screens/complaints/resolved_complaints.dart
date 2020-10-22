import 'package:ChitChat/screens/complaints/complaint_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class ResolvedComplaints extends StatelessWidget {
   final String userId;
  ResolvedComplaints({@required this.userId});

 @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('complaints')
                        .where('userId', isEqualTo: userId).where('isPending',isEqualTo: false)
                        .snapshots(),

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
                                  // print(complaintDocs[index]);
                                  Navigator.of(context).pushNamed(
                                      ComplaintDetail.routeName,
                                      arguments: <String, dynamic>{
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
                                        title: Text(
                                            complaintDocs[index]['subject']),
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
            ],
        ),
      ),
    );
  }
}
