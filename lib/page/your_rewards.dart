import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YourRewards extends StatefulWidget {
  _YourRewardsState createState() => _YourRewardsState();
}

class _YourRewardsState extends State<YourRewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                AppLocalizations.of(context).yourRewardsWillAppearHere,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
