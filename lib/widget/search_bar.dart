import 'package:flutter/material.dart';
import 'package:organic/dialogBoxes/notifications.dart';
import 'package:organic/widget/show_dialog.dart';
import 'package:organic/widget/top_banner.dart';

class SearchBar extends StatefulWidget {
  SearchBarState createState() => new SearchBarState();
}

class SearchBarState extends State<SearchBar> {
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
        Expanded(
          child: Center(
            child: Text(
              "Organic Express",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 18,
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
