import 'package:flutter/material.dart';
import 'package:organic/widget/next_page_button.dart';
import 'package:organic/widget/profile_pic.dart';
import 'package:organic/widget/text_field.dart';

class RegisterDetailPage extends StatefulWidget {
  RegisterDetailPageState createState() => new RegisterDetailPageState();
}

class RegisterDetailPageState extends State<RegisterDetailPage> {
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
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 50,
                ),
                // Add Profile Picture
                new ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(75.0),
                  ),
                  child: Image.network(
                    '1.jpeg',
                    // width: 300,
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                new SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                // Name of User

                CustomTextField(
                  "Name",
                  "Full Name",
                  false, // isPassword
                ),

                new SizedBox(
                  height: 30.0,
                ),

                //  DOB of User

                CustomTextField(
                  "Date of Birth",
                  "DD/MM/YYYY",
                  false, // isPassword
                ),

                new SizedBox(
                  height: 30.0,
                ),

                //  Contact of User

                CustomTextField(
                  "Mobile no.",
                  "",
                  false, // isPassword
                ),

                new SizedBox(
                  height: 30.0,
                ),

                //  DOB of User

                CustomTextField(
                  "Address",
                  "State/City",
                  false, // isPassword
                ),

                new SizedBox(
                  height: 30.0,
                ),

                // GPS

                new Row(
                  children: <Widget>[
                    new Text(
                      "GPS",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(right: 10.0),
                    ),
                    new Checkbox(
                      value: gpsCheck,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getGpsColor),
                      onChanged: gpsCheckFunction,
                    ),
                  ],
                ),

                new SizedBox(
                  height: 10.0,
                ),

                // Terms and Conditions

                new Row(
                  children: <Widget>[
                    new Checkbox(
                      value: agreementCheck,
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith(getAgreementColor),
                      onChanged: agreementCheckFunction,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(right: 10.0),
                    ),
                    new Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                // navigator

                NextPageButton("/request_page"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
