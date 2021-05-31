import 'package:flutter/material.dart';

class ProcurementUpdateDialogBox extends StatefulWidget {
  ProcurementUpdateDialogBoxState createState() =>
      new ProcurementUpdateDialogBoxState();
}

class ProcurementUpdateDialogBoxState
    extends State<ProcurementUpdateDialogBox> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text("Proc update")),
      ],
    );
  }
}
