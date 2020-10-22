import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class PollScreen extends StatelessWidget {
  static const routeName = '/poll_screen';
  @override
  Widget build(BuildContext context) {
  final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Template(userId: userId,),
    );
  }
}
