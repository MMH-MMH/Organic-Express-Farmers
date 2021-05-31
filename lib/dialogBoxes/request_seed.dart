import 'package:flutter/material.dart';

class RequestSeed extends StatefulWidget {
  RequestSeedState createState() => new RequestSeedState();
}

class RequestSeedState extends State<RequestSeed> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text("Request")),
      ],
    );
  }
}
