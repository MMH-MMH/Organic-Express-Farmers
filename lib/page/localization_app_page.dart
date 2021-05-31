import 'package:flutter/material.dart';
import 'package:organic/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/widget/language_picker_widget.dart';

class LocalizationAppPage extends StatefulWidget {
  @override
  _LocalizationAppPageState createState() => _LocalizationAppPageState();
}

class _LocalizationAppPageState extends State<LocalizationAppPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Choose Your Regional Language",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
                LanguagePickerWidget(),
                const SizedBox(height: 32),
                new Text(
                  "${AppLocalizations.of(context).helloWorld}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                new Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.of(context).pushNamed("/register_page");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
