import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo(this.userData);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Info(AppLocalizations.of(context).contact,
            this.userData["contact"].toString()),
        Info(AppLocalizations.of(context).chooseFarming,
            this.userData["farmingType"].toString()),
        Info(AppLocalizations.of(context).cropsYouGrow,
            this.userData["cropsList"].toString()),
        Info(AppLocalizations.of(context).landSize,
            this.userData["landSize"].toString()),
        Info(AppLocalizations.of(context).certificate,
            this.userData["certificateNumber"].toString()),
        Info(AppLocalizations.of(context).currAdd,
            this.userData["currAdd"].toString()),
      ],
    );
  }
}

class Info extends StatelessWidget {
  Info(this.ques, this.ans);
  final String ques, ans;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.ques,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 15,
          ),
        ),
        Text(
          this.ans,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Divider(
          height: 2.0,
          thickness: 2,
          indent: 0,
          endIndent: MediaQuery.of(context).size.width * 0.4,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
