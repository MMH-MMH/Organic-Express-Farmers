import 'package:flutter/material.dart';
import 'package:organic/dialogBoxes/notifications.dart';
import 'package:organic/widget/show_dialog.dart';

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
        new Theme(
          data: new ThemeData(
            primaryColor: Colors.black87,
          ),
          child: new Expanded(
            child: new TextFormField(
              obscureText: false,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0),
                  borderSide: new BorderSide(),
                ),
                contentPadding: new EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                suffixIcon: new IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: null,
                ),
                hintText: "Organic Express",
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_sharp,
          ),
          onPressed: showNotifications,
        ),
      ],
    );
  }
}
