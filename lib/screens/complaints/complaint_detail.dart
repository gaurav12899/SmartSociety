import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ComplaintDetail extends StatelessWidget {
  static const routeName = '/complaints/complaint_detail';
  // final userId;
  // final complaintId;
  // ComplaintDetail(this.userId, this.complaintId);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> complaintDetails =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Template(
        userId: complaintDetails['userId'],
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Complaint Detail",
              style: TextStyle(fontSize: 30),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Complaint Time",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat()
                          .format(complaintDetails['id']['createdAt'].toDate()),
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Subject",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      complaintDetails['id']['subject'],
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      complaintDetails['id']['description'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          if (complaintDetails['id']['isPending']) Container(
                // alignment: Alignment.bottomLeft,
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                child: FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text("Are You Sure??",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                actions: [
                                  FlatButton(
                                      onPressed: () async {
                                        await Firestore.instance
                                            .collection('complaints')
                                            .document(
                                                '${complaintDetails['id'].documentID}')
                                            .updateData({'isPending': true});

                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No")),
                                  FlatButton(
                                      onPressed: () async {
                                        await Firestore.instance
                                            .collection('complaints')
                                            .document( '${complaintDetails['id'].documentID}')
                                            .updateData({'isPending': false});

                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Yes"))
                                ],
                              ));
                    },
                    child: Text(
                      'PEOBLEM SOLVED?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }
}
