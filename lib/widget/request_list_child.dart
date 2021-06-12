import 'package:flutter/material.dart';
import 'package:organic/dialogBoxes/procurement_change.dart';
import 'package:organic/dialogBoxes/procurement_update.dart';
import 'package:organic/dialogBoxes/request_seed.dart';
import 'package:organic/widget/show_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestList extends StatefulWidget {
  RequestListState createState() => new RequestListState();
}

class RequestListState extends State<RequestList> {
  showReqDiag() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(RequestSeed());
      },
    );
  }

  showProcUpdateDiag() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(ProcurementUpdateDialogBox());
      },
    );
  }

  showProcChangeDiag() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(ProcurementChangeDialogBox());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 30,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).requestItems,
                  // "Request seed, bio fertilizers",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: showReqDiag,
                ),
              ),
            ],
          ),
          Divider(
            indent: 30,
            height: 2,
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).changeProcurement,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: showProcUpdateDiag,
                ),
              ),
            ],
          ),
          Divider(
            indent: 30,
            height: 2,
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).upcomingSchedule,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: showProcChangeDiag,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
