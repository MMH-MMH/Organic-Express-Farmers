import 'package:flutter/material.dart';

class ProcurementChangeDialogBox extends StatefulWidget {
  ProcurementChangeDialogBoxState createState() =>
      new ProcurementChangeDialogBoxState();
}

class ProcurementChangeDialogBoxState
    extends State<ProcurementChangeDialogBox> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text("Proc Change")),
      ],
    );
  }
}
