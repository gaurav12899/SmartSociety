import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorItem extends StatefulWidget {
  final userId;
  final vendorDocs;
  final index;
  VendorItem(this.userId, this.vendorDocs, this.index);

  @override
  _VendorItemState createState() => _VendorItemState();
}

class _VendorItemState extends State<VendorItem> {
  var _expanded = false;

  void _launchURL(String myUrl) async {
    try {
      final url = myUrl;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: _expanded ? 200 : 100,
      child: Card(
        color: Colors.amber,
        child: Column(
          children: [
            ListTile(
                title: Text(widget.vendorDocs[widget.index]['shopname']),
                subtitle: Text(widget.vendorDocs[widget.index]['ownername']),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 40,
                  backgroundImage: NetworkImage(
                      widget.vendorDocs[widget.index]['image_url']),
                ),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                )),
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                height: _expanded ? 120 : 0,
                color: Colors.blueGrey,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(
                    widget.vendorDocs[widget.index]['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ))),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: FlatButton(
                        onPressed: () {
                          _launchURL(
                              "tel:+91 ${widget.vendorDocs[widget.index]['phone']}");
                        },
                        child: Text("Call Now"),
                      ),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
