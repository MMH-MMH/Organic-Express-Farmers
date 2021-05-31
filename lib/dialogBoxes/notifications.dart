import 'package:flutter/material.dart';

class NotificationDialogBox extends StatefulWidget {
  NotificationDialogBoxState createState() => new NotificationDialogBoxState();
}

class NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text("Notifications")),
      ],
    );
  }
}
