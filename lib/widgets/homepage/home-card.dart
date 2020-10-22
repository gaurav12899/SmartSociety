import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final String route;
  final String userId;

  HomeCard({
    @required this.title,
    @required this.icon,
    @required this.route,
    @required this.userId
  });
  void goToFunction(BuildContext ctx, String route) {
    Navigator.of(ctx).pushNamed(route,arguments: userId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToFunction(context, route),
      child: Card(
        elevation: 10,
        // color: Theme.of(context).accentColor,
        // margin: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 2),
          // width: 200,
          child: ListTile(
            leading: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            trailing: CircleAvatar(child: icon),
          ),
        ),
      ),
    );
  }
}
