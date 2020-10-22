import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:flutter/material.dart';

class VendorListScreen extends StatelessWidget {
  static const routeName = '/vedor-list';
  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Template(userId: userId,
      child: Text("vendorList"),),
    );
  }
}
