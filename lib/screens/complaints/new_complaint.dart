
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
class NewComplaint extends StatelessWidget {
  static var subject;
  static var description;

  final String userId;
  NewComplaint(this.userId);

  Future<void> submitComplaint( context) async {
    try {
      await Firestore.instance
          .collection("complaints")
          .add({
        'subject': subject,
        'description': description,
        'isPending': true,
        'userId':userId,
        'createdAt':DateTime.now().toUtc()
      });
      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      var message = "Something went wrong!!";
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Complaint Box",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Subject"),
                      onChanged: (val) {
                        subject = val;
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(labelText: "Description"),
                      minLines: 1,
                      maxLines: 10,
                      onChanged: (val) {
                        description = val;
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    RaisedButton(
                      onPressed: () {
                        submitComplaint(context);
                      },
                      child: Text("Launch Complaint"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
