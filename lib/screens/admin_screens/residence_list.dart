import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class ResidenceList extends StatefulWidget {
  final userId;
  ResidenceList(this.userId);
  @override
  _ResidenceListState createState() => _ResidenceListState();
}

class _ResidenceListState extends State<ResidenceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Template(userId: widget.userId,),
    );
  }
}
