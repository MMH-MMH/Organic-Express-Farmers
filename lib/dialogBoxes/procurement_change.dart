// Upcoming schedule
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            AppLocalizations.of(context).notificationsAboutWhenOurTeam,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
