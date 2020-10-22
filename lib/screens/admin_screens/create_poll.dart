import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class CreatePoll extends StatelessWidget {
  static const routeName = '/create-poll';
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: Template(userId: userId,child: Text("Hello world"),));
  }
}
