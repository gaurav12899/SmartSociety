import 'package:ChitChat/screens/admin_screens/create_poll.dart';
import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class PollsResult extends StatefulWidget {
  final userId;
  PollsResult(this.userId);
  @override
  _PollsResultState createState() => _PollsResultState();
}

class _PollsResultState extends State<PollsResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Template(
        userId: widget.userId,
        child: RaisedButton(onPressed: () {
          Navigator.of(context).pushNamed(CreatePoll.routeName,arguments: widget.userId);
        },child: Text("Create New Poll")
        ,),
      ),
    );
  }
}
