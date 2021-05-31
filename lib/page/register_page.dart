import 'package:flutter/material.dart';
import 'package:organic/widget/next_page_button.dart';
import 'package:organic/widget/text_field.dart';
import 'package:organic/widget/top_banner.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool gpsCheck = false;
  bool agreementCheck = false;

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

                    // Name of User

                    CustomTextField(
                      "Email",
                      "",
                      false, // isPassword
                    ),

                    new SizedBox(
                      height: 30.0,
                    ),

                    //  DOB of User

                    CustomTextField(
                      "Password",
                      "",
                      true, // isPassword
                    ),

                    new SizedBox(
                      height: 30.0,
                    ),

                    new Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                      ),
                    ),

                    new SizedBox(
                      height: 10.0,
                    ),

                    // Login Link

                    FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/request_page");
                      },
                      child: Text(
                        'LOGIN',
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    // navigator

                    new SizedBox(
                      height: 70.0,
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
                                Navigator.of(context).pushNamed("/login_page");
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

                        // Register and detail page link
                        new Expanded(
                          child: NextPageButton("/register_detail_page"),
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
