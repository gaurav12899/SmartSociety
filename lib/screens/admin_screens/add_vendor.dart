import 'package:ChitChat/widgets/homepage/template.dart';
import 'package:ChitChat/widgets/pickers/vendor_image_picker.dart';
import 'package:flutter/material.dart';
import '../../widgets/homepage/template.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class AddVendor extends StatefulWidget {
  static const routeName = 'add-vendor-screen';

  @override
  _AddVendorState createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formValues = {
    'shopName': '',
    'ownerName': '',
    'phone': '',
    'description': '',
    'image': null
  };
  var _isLoading = false;
  Future saveForm() async {
  
    final isValid = _formKey.currentState.validate();
    // FocusScope.of(context).unfocus();

    if(isValid){
    setState(() {
      _isLoading = true;
    });
      _formKey.currentState.save();
          try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("vendors")
          .child(_formValues['shopName'] + '.jpg');
      var checkConnectivity = await Connectivity().checkConnectivity();
      if (checkConnectivity == ConnectivityResult.none) {
        setState(() {
          _isLoading = false;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Some Error occurred!!"),
                  content: Text(
                      "You are not Connected with Internet.Please Try again!!"),
                  actions: [
                    FlatButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        });
      }
      await ref.putFile(_formValues['image']).onComplete;

      final url = await ref.getDownloadURL();

      await Firestore.instance.collection('vendors').add({
        'shopname': _formValues['shopName'],
        'ownername': _formValues['ownerName'],
        'image_url': url,
        'description': _formValues['description'],
        'phone': _formValues['phone']
      });
      // resp.timeout(Duration(seconds: 5));

    } catch (err) {
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }




    }

  void imagePickFn(File _pickedImage) {
    _formValues['image'] = _pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Template(
      userId: userId,
      child: _isLoading
          ? Center(
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Adding Vendor Please Wait...")
                  ],
                ),
              ),
            )
          : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Text("Add Vendors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Shop Name"),
                              onSaved: (val) {
                                _formValues['shopName'] = val;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Shop Name can't be empty";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Owner Name"),
                              onSaved: (val) {
                                _formValues['ownerName'] = val;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Owner Name can't be empty";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Phone number",
                              ),
                              onSaved: (val) {
                                _formValues['phone'] = val;
                              },
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.length != 10) {
                                  return "Phone number can't be greater or lesser than 10";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Discription",
                              ),
                              onSaved: (val) {
                                _formValues['description'] = val;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please Provide the description ";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              minLines: 1,
                              maxLines: 5,
                            ),
                            VendorImagePicker(imagePickFn)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                        onPressed: _isLoading ? null : saveForm,
                        child: Text("Add Vendor")),
                  ],
                ),
              ),
            ),
    ));
  }
}
