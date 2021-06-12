import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:organic/widget/top_banner.dart';
import 'package:organic/services/authservice.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool gpsCheck = false;
  bool agreementCheck = false;
  bool sending = false;

  LocalStorage storage = new LocalStorage('organic');

  void gpsCheckFunction(bool gpsCheckCurrent) {
    setState(() {
      gpsCheck = !gpsCheck;
    });
  }

  void agreementCheckFunction(bool agreementCheckCurrent) {
    setState(() {
      agreementCheck = !agreementCheck;
    });
  }

  navigatorFunction() async {
    print("Contact is $contact");

    setState(() {
      sending = true;
    });

    String token, to;
    var res;

    res = await AuthService().login(contact);
    // token = (str.split('"')[11]).toString(),
    print("Auth contact res -- $res");
    if (res[0]) {
      token = res[1];
      print("Token --- $token");
      storage.setItem('token', token);
      to = storage.getItem('token');
      print("setStorage -- $to");

      Navigator.of(context).pushNamed("/otp_verification_page");
    }
    setState(() {
      sending = false;
    });
  }

  String contact = "", indicatorText = "";

  bool disabled = true;

  Color indicatorColor = Color(0xFF9E9E9E);

  @override
  void initState() {
    storage.clear();
    super.initState();
    print("register page contact ${storage.getItem('contact')}");
    storage.clear();
    print("register page contact ${storage.getItem('contact')}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            TopBanner(
              AppLocalizations.of(context).createAFreeAccount,
              // "CreateAFreeAccount",
              // "Create account by filling details below",
              AppLocalizations.of(context).createAccountByFillingDetailsBelow,
              // Language().getString("Create account by filling details below"),
            ),
            new Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      height: 50.0,
                    ),

                    // Contact Field

                    new Theme(
                      data: new ThemeData(
                        primaryColor: Colors.black87,
                      ),
                      child: new TextField(
                        obscureText: false,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: new EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          labelText: AppLocalizations.of(context).contact,
                          prefixStyle: new TextStyle(
                            color: Colors.black,
                          ),
                          prefixText: "+91 ",
                          hintText: AppLocalizations.of(context).phoneNumber,
                        ),
                        onChanged: (value) {
                          setState(() {
                            contact = value;
                            RegExp exp = RegExp(r'^[0-9]+$');
                            int len = contact.length;

                            if (len == 0) {
                              indicatorText =
                                  AppLocalizations.of(context).enterYourContact;

                              disabled = true;
                              indicatorColor = Colors.grey;
                            } else if (len != 10) {
                              indicatorText =
                                  AppLocalizations.of(context).invalidContact;

                              disabled = true;
                              indicatorColor = Colors.red;
                            } else if (len == 10 && !exp.hasMatch(contact)) {
                              indicatorText =
                                  AppLocalizations.of(context).invalidContact;

                              disabled = true;
                            } else {
                              indicatorText = "";
                              disabled = false;
                              indicatorColor = Colors.black;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        indicatorText,
                        style: TextStyle(
                          color: indicatorColor,
                        ),
                      ),
                    ),

                    new SizedBox(
                      height: 20,
                    ),

                    new ElevatedButton(
                      onPressed: disabled ? null : navigatorFunction,
                      style: ElevatedButton.styleFrom(
                        primary: sending ? Colors.grey : Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          AppLocalizations.of(context).getOtp,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
