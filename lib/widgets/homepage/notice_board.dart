import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(0, 39, 0, 0.9),
        border: Border.all(color: Colors.amber, width: 12),
      ),
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.width * .6,
      margin: EdgeInsets.only(top: 10),

      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                color: Colors.green,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(children: [
              Text(
                "Notice Board",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "The secret of getting ahead is getting started...",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
