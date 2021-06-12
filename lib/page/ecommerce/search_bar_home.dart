import 'package:flutter/material.dart';
import 'package:organic/dialogBoxes/notifications.dart';
import 'package:organic/widget/show_dialog.dart';
import 'package:organic/widget/top_banner.dart';

class SearchBarHome extends StatefulWidget {
  SearchBarHomeState createState() => new SearchBarHomeState();
}

class SearchBarHomeState extends State<SearchBarHome> {
  showNotifications() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(NotificationDialogBox());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Theme(
          data: new ThemeData(
            primaryColor: Colors.black87,
          ),
          child: new Expanded(
            child: new TextFormField(
              obscureText: false,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                suffixIcon: new IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: null,
                ),
                hintText: "Search...",
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.teal,
          ),
          onPressed: () {
            showNotifications();
          },
        ),
      ],
    );
  }
}
