import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/methods/isauthenticated.dart';

import 'package:organic/widget/language_picker_widget.dart';
import 'package:organic/widget/loader.dart';

class LocalizationAppPage extends StatefulWidget {
  @override
  _LocalizationAppPageState createState() => _LocalizationAppPageState();
}

class _LocalizationAppPageState extends State<LocalizationAppPage> {
  LocalStorage storage = LocalStorage('organic');

  Future<bool> isAuth() async {
    await storage.ready;
    var ct = storage.getItem('contact');
    return (ct != null);
  }

  bool auth = false, loadHome = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        loadHome = true;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          isAuth().then((res) {
            if (!res) {
              storage.clear();
            } else {
              auth = true;
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return (loadHome == false)
        ? Loader()
        : Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      new Text(
                        "Choose Your Language",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      new Text(
                        "अपनी भाषा चुनें",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.teal[300],
                        ),
                      ),
                      SizedBox(height: 32),
                      LanguagePickerWidget(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      new Align(
                        alignment: Alignment.topRight,
                        child: new Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.teal,
                                Colors.teal[200],
                              ],
                            ),
                          ),
                          child: new IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            iconSize: 40.0,
                            onPressed: () {
                              auth
                                  ? Navigator.of(context)
                                      .pushNamed("/request_page")
                                  : Navigator.of(context)
                                      .pushNamed("/register_page");
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
