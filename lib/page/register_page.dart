import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:organic/widget/next_page_button.dart';
import 'package:organic/widget/text_field.dart';
import 'package:organic/widget/top_banner.dart';
import 'package:organic/services/authservice.dart';
import 'package:localstorage/localstorage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool gpsCheck = false;
  bool agreementCheck = false;

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
    // print("Contact is $contact");

    String token, to;

    await AuthService().login(contact).then(
          (res) => {
            // token = (str.split('"')[11]).toString(),
            token = res,
            // print("Token --- $token"),
            storage.setItem('token', token),
            to = storage.getItem('token'),
            // print("setStorage -- $to")
          },
        );

    Navigator.of(context).pushNamed("/otp_verification_page");
  }

  String contact = "", indicatorText = "Enter your Contact";

  bool disabled = true;

  Color indicatorColor = Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            TopBanner(
              "Create a free account",
              "Create account by filling details below",
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
                          labelText: "Contact",
                          prefixStyle: new TextStyle(
                            color: Colors.black,
                          ),
                          prefixText: "+91 ",
                          hintText: "Phone Number",
                        ),
                        onChanged: (value) {
                          setState(() {
                            contact = value;
                            RegExp exp = RegExp(r'^[0-9]+$');
                            int len = contact.length;
                            if (len == 0) {
                              indicatorText = "Enter your Contact";
                              disabled = true;
                              indicatorColor = Colors.grey;
                            } else if (len != 10) {
                              indicatorText = "Invalid Contact";
                              disabled = true;
                              indicatorColor = Colors.red;
                            } else if (len == 10 && !exp.hasMatch(contact)) {
                              indicatorText = "Invalid Contact";
                              disabled = true;
                            } else {
                              indicatorText = "";
                              disabled = false;
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
                      height: 30.0,
                    ),

                    new Row(
                      // Lincenses and Agreements link
                      children: <Widget>[
                        new Expanded(
                          child: new Align(
                            alignment: Alignment.topLeft,
                            child: new FlatButton(
                              color: Colors.transparent,
                              splashColor: Colors.black26,
                              onPressed: () {
                                Navigator.of(context).pushNamed("/");
                              },
                              child: Text(
                                'Liscense and Agreements',
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Align(
                          alignment: Alignment.topRight,
                          child: new Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                              gradient: disabled
                                  ? (LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF9E9E9E),
                                        Color(0xFFFFFFFF),
                                      ],
                                    ))
                                  : (LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff55ce23),
                                        Color(0xffbefd32),
                                      ],
                                    )),
                            ),
                            child: new IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ),
                              iconSize: 40.0,
                              onPressed: disabled ? null : navigatorFunction,
                            ),
                          ),
                        ),
                      ],
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
