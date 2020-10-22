import 'package:ChitChat/widgets/homepage/notice_board.dart';
import 'package:ChitChat/widgets/homepage/template.dart';

import '../widgets/homepage/home-card.dart';
import '../models/function_list.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class MyHomePage extends StatelessWidget {
  final String userId;
  MyHomePage(this.userId);

  void profilePage(BuildContext context) {
    print("user id is $userId");
    Navigator.of(context).pushNamed(Profile.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Home"),
        // ),

        body: Template(
          
          userId: userId,
          child: Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * .875,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  NoticeBoard(),
                  Expanded(
                      // width: double.infinity,
                      // color: Colors.red,
                      // height: 300,
                      child: Padding(
                      padding: EdgeInsets.all(20),
                        // padding: const EdgeInsets.all(8.0),
                        child: GridView(
                          padding: const EdgeInsets.all(5),
                          children: FUNCTION_LIST.map((item) {
                            return HomeCard(

                              title: item.title,
                              icon: item.icon,
                              route: item.route,
                              userId: userId,
                            );
                          }).toList(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:MediaQuery.of(context).size.width,
                            childAspectRatio: 10/ 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 10,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
