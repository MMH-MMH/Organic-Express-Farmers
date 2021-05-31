import 'package:flutter/material.dart';
import 'package:organic/widget/text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
    Color getGpsColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.teal;
    }

    Color getAgreementColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.teal;
    }

    return new Scaffold(
      body: new Container(
        margin: new EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Login",
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                ),
              ),

              new SizedBox(
                height: 30.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
