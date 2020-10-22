import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';
class CreateEvents extends StatefulWidget {
  final userId;
  CreateEvents(this.userId);
  @override
  _CreateEventsState createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Template(userId: widget.userId,),
      
    );
  }
}