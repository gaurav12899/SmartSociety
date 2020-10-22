import 'package:ChitChat/screens/admin_screens/add_vendor.dart';
import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:ChitChat/widgets/vendor_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorAdmin extends StatefulWidget {
  final userId;
  VendorAdmin(this.userId);
  static const routeName = '/vendor_admin';

  @override
  _VendorAdminState createState() => _VendorAdminState();
}

class _VendorAdminState extends State<VendorAdmin> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Template(
          userId: widget.userId,
          child: Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Vendors",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('vendors')
                            .snapshots(),
                        builder: (ctx, vendorsDocuments) {
                          if (vendorsDocuments.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final vendorDocs = vendorsDocuments.data.documents;

                            return ListView.builder(
                                itemCount: vendorDocs.length,
                                itemBuilder: (ctx, index) {
                                 return VendorItem(widget.userId,vendorDocs,index);
                                });
                          }
                        }),
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AddVendor.routeName,
                            arguments: widget.userId);
                      },
                      child: Text(
                        "Add new",
                      ))
                ],
              ),
            ),
          )),
    );
  }
}

//   @override
//   _VendorAdminState createState() => _VendorAdminState();
// }

// class _VendorAdminState extends State<VendorAdmin> {
