import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintDetailAdmin extends StatelessWidget {
  static const routeName = '/complaint_detail_admin';

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
                    ),Text(
                      "Complaint Time",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),Text(
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
          ],
        ),
      ),
    );
  }
}
