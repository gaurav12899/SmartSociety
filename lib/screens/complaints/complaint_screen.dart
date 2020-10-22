import 'package:ChitChat/screens/complaints/open_complaints.dart';
import 'package:ChitChat/screens/complaints/resolved_complaints.dart';
import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class ComplaintScreen extends StatelessWidget {
  static const routeName = '/complaint_screen';
  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Template(
        userId: userId,
        child: ComplaintWidget(userId: userId),
      )),
    );
  }
}

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    Key key,
    @required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.green,
            appBar: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.error),
                  text: "My Complaints",
                ),
                Tab(
                  icon: Icon(Icons.check_circle),
                  text: "Resolved Complaints",
                ),
              ],
            ),
            body: TabBarView(children: [
              OpenComplaints(
                userId: userId,
              ),
              ResolvedComplaints(userId: userId),
            ]),
          ),
        ),
      ),
    );
  }
}
