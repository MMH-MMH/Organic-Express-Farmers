import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/registerredirect.dart';
import 'package:organic/services/authservice.dart';
import 'package:organic/widget/dropdown.dart';
import 'package:organic/widget/liscenseAndAgreements.dart';
import 'package:organic/widget/navbar.dart';
import 'package:organic/widget/next_page_button.dart';
import 'package:organic/widget/profile_pic_picker.dart';
import 'package:organic/widget/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterDetailPage extends StatefulWidget {
  RegisterDetailPageState createState() => new RegisterDetailPageState();
}

class RegisterDetailPageState extends State<RegisterDetailPage> {
  bool agreementCheck = false, organicCheck = false, inorganicCheck = false;
  List<String> farmingType = [];

  LocalStorage storage = LocalStorage('organic');
  String contact, landSizeUnit = "Acre";

  Widget nullContact;

  var data = {
    "name": "",
    "currAdd": "",
    "anotherNumber": "",
    "landSize": "",
    "landSizeUnit": "Acre",
    "cropsList": "",
    "certificateNumber": "",
    "farmingType": [],
    "contact": "",
  };

  List<String> reqFields;

  ////   SOME METHODS //////////

  bool validForm() {
    reqFields = [
      "name",
      "currAdd",
      "landSize",
      "cropList",
      "darmingType",
      "contact"
    ];
    for (String x in reqFields) {
      if ((data[x].toString()).length == 0) {
        print("validation: false at - $x");
        Fluttertoast.showToast(
          msg: "Invalid Form",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.red[800],
          fontSize: 10,
        );
        return false;
      }
    }
    print("validation: - ${agreementCheck.toString()}");
    if (agreementCheck == false) {
      Fluttertoast.showToast(
        msg: "Invalid Form",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red[800],
        fontSize: 10,
      );
    }
    return (agreementCheck == true);
  }

  void check() {
    Methods().redirectToRegister(contact, context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      contact = storage.getItem('contact');
      storage.deleteItem('contact');
      data["contact"] = contact;
    });
  }

  void agreementCheckFunction(bool agreementCheckCurrent) {
    setState(() {
      agreementCheck = !agreementCheck;
    });
  }

  void organicCheckFunction(bool organicCheckCurrent) {
    setState(() {
      organicCheck = !organicCheck;
      if (organicCheck) {
        reqFields.add("certificateNumber");
        farmingType.add("Organic");
      } else {
        farmingType.remove("Organic");
        reqFields.remove("certificateNumber");
      }

      data["farmingType"] = farmingType;
    });
  }

  void inorganicCheckFunction(bool inorganicCheckCurrent) {
    setState(() {
      inorganicCheck = !inorganicCheck;
      if (inorganicCheck)
        farmingType.add("Inorganic");
      else
        farmingType.remove("Inorganic");

      data["farmingType"] = farmingType;
    });
  }

  void navigatorFuntion() async {
    print("contact -- $contact");
    var res;
    if (contact == null) {
      Fluttertoast.showToast(
        msg: "Verify your Contact in previous step",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red[800],
        fontSize: 10,
      );
      Navigator.of(context).pushNamed("/register_page");
    } else {
      res = await AuthService().register(data);
      if (storage.getItem('contact') != null) {
        storage.deleteItem('contact');
      }
      if (storage.getItem('name') != null) {
        storage.deleteItem('name');
      }
      if (res == false) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/register_page");
      } else {
        storage.setItem('contact', data['contact']);
        storage.setItem('name', data['name']);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/request_page");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color checkboxColor(Set<MaterialState> states) {
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
                // Navbar(),
                new SizedBox(
                  height: 50,
                ),

                // Add Profile Picture
                ProfilePic(contact),
                new SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                // Name of User

                CustomTextField(
                  (AppLocalizations.of(context).name + "*")
                      .toString(), // labeltext
                  "", // hinttext
                  false, // isPassword
                  (val) {
                    check();
                    // onChnaged
                    data["name"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                CustomTextField(
                  (AppLocalizations.of(context).currAdd + "*").toString(), "",
                  false, // isPassword
                  (val) {
                    data["currAdd"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                CustomTextField(
                  (AppLocalizations.of(context).anotherNumber), "",
                  false, // isPassword
                  (val) {
                    data["anotherNumber"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                // ///////// Land Size /////

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Align(
                //       alignment: Alignment.topLeft,
                //       child:

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.black87,
                        ),
                        child: new TextField(
                          onChanged: (val) {
                            data["landSize"] = val;
                          },
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: new EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            labelText: AppLocalizations.of(context).landSize,
                            prefixStyle: new TextStyle(
                              color: Colors.black,
                            ),
                            hintText: "",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Dropdown(
                      ['Acre', 'Hectare'],
                      (String newVal) {
                        setState(() {
                          landSizeUnit = newVal;
                          data["landSizeUnit"] = landSizeUnit;
                        });
                      },
                      landSizeUnit,
                    ),
                  ],
                ),

                SizedBox(height: 10),
                // ),

                //   ],
                // ),

                new SizedBox(
                  height: 30.0,
                ),

                // //////// CROPS YOU GROW ////////

                CustomTextField(
                  AppLocalizations.of(context).cropsYouGrow + "*", "",
                  false, // isPassword
                  (val) {
                    data["cropsList"] = val;
                  },
                ),

                new SizedBox(
                  height: 5.0,
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context).cropsListDesc,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                new SizedBox(
                  height: 30.0,
                ),

                // //////// SELECT INORGANIC/ORGANIC      ////////   ////////
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context).chooseFarming + "*",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                new Row(
                  children: <Widget>[
                    new Text(
                      AppLocalizations.of(context).organic,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(right: 10.0),
                    ),
                    new Checkbox(
                      value: organicCheck,
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith(checkboxColor),
                      onChanged: organicCheckFunction,
                    ),
                    SizedBox(width: 20),
                    if (organicCheck == true)
                      Expanded(
                        child: CustomTextField(
                          AppLocalizations.of(context).certificate + "*",
                          "",
                          false,
                          (val) {
                            data["certificateNumber"] = val;
                          },
                        ),
                      ),
                  ],
                ),

                new Row(
                  children: <Widget>[
                    new Text(
                      AppLocalizations.of(context).inorganic,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(right: 10.0),
                    ),
                    new Checkbox(
                      value: inorganicCheck,
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith(checkboxColor),
                      onChanged: inorganicCheckFunction,
                    ),
                  ],
                ),

                SizedBox(height: 30),

                ////////// CERTIFICATE NUMBER ///////////

                // new SizedBox(
                //   height: 10.0,
                // ),

                // Terms and Conditions

                Agreements(
                    agreementCheck, agreementCheckFunction, checkboxColor),

                // navigator

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
                      onPressed: (validForm()) ? navigatorFuntion : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
