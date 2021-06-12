import 'package:flutter/material.dart';
import 'package:organic/page/profile_page.dart';
import 'package:organic/page/farmers_home.dart';

class LoggedInHome extends StatefulWidget {
  _LoggedInHomeState createState() => _LoggedInHomeState();
}

class _LoggedInHomeState extends State<LoggedInHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: TabBarView(
          children: <Widget>[RequestPage(), ProfilePage()],
        ),
      ),
    );
  }
}
