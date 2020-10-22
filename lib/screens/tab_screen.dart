import 'package:ChitChat/screens/admin_screens/create_events.dart';
import 'package:ChitChat/screens/admin_screens/residence_list.dart';
import 'package:ChitChat/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'admin_screens/polls_result.dart';
import './admin_screens/complaints.dart';
import 'admin_screens/vendorsAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabScreen extends StatefulWidget {
  final String userId;
  TabScreen(this.userId);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;
  var _noticeBoardText;
  var noticeBoardController = TextEditingController();
  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  void initState() {
    _pages = [
      {
        'page': MyHomePage(widget.userId),
        'title': 'Home',
      },
      {
        'page': PollsResult(widget.userId),
        'title': 'My Polls',
      },
      {
        'page': Complaints(widget.userId),
        'title': 'Complaints',
      },
      {
        'page': VendorAdmin(widget.userId),
        'title': 'Vendors',
      },
      {
        'page': ResidenceList(widget.userId),
        'title': 'ResidenceList',
      },
      {
        'page': CreateEvents(widget.userId),
        'title': 'CreateEvents',
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // _pages[_selectedIndex]['page'],

            SpinCircleBottomBarHolder(
      bottomNavigationBar: SCBottomBarDetails(items: <SCBottomBarItem>[
        SCBottomBarItem(
            title: "Home",
            icon: Icons.home,
            onPressed: (() {
              setState(() {
                _selectedIndex = 0;
              });
            })),
        SCBottomBarItem(
            title: "Polls",
            icon: Icons.add_chart,
            onPressed: (() {
              setState(() {
                _selectedIndex = 1;
              });
            })),
        SCBottomBarItem(
            title: "Complaints",
            icon: Icons.error,
            onPressed: (() {
              setState(() {
                _selectedIndex = 2;
              });
            })),
        SCBottomBarItem(
            title: "Flat List",
            icon: Icons.list_alt_outlined,
            onPressed: (() {
              setState(() {
                _selectedIndex = 4;
              });
            }))
      ], circleItems: <SCItem>[
        SCItem(
            icon: Icon(Icons.list_alt_outlined),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            }),
        SCItem(
            icon: Icon(Icons.event),
            onPressed: () {
              setState(() {
                _selectedIndex = 5;
              });
            }),
        SCItem(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    labelText: "Add on Notice Board"),
                                controller: noticeBoardController,
                                
                                onSubmitted: (value) {
                                  setState(() async {
                                    await Firestore.instance
                                        .collection('admin')
                                        .document('adminFeatures')
                                        .setData({'noticeBoard': value});
                                    
                                    // Scaffold.of(ctx).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text("done"),
                                    //   ),
                                    // );

                                      Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
            })
      ]),
      child: _pages[_selectedIndex]['page'],
    )
        // BottomNavigationBar(
        //     onTap: _selectPage,
        //     selectedItemColor: Colors.amber,
        //     unselectedItemColor: Colors.white,
        //     currentIndex: _selectedIndex,
        //     // showSelectedLabels: _pages[_selectedIndex]['title'],
        //     items: [
        //       BottomNavigationBarItem(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.home),
        //         label: "",
        //       ),
        //       BottomNavigationBarItem(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.poll),
        //         label: "",
        //       ),
        //       BottomNavigationBarItem(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.error),
        //         label: "",
        //       ),
        //       BottomNavigationBarItem(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.list),
        //         label: "",
        //       ),
        //       BottomNavigationBarItem(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         icon: Icon(Icons.people),
        //         label: "",
        //       ),
        //     ]),
        );
  }
}

