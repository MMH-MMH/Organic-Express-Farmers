import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/registerredirect.dart';
import 'package:organic/services/authservice.dart';
import 'package:organic/widget/liscenseAndAgreements.dart';
import 'package:organic/widget/next_page_button.dart';
import 'package:organic/widget/profile_pic.dart';
import 'package:organic/widget/text_field.dart';

class RegisterDetailPage extends StatefulWidget {
  RegisterDetailPageState createState() => new RegisterDetailPageState();
}

class RegisterDetailPageState extends State<RegisterDetailPage> {
  bool agreementCheck = false, organicCheck = false, inorganicCheck = false;
  List<String> farmingType = [];

  LocalStorage storage = LocalStorage('organic');
  String contact;

  Widget nullContact;

  var data = {
    "name": "",
    "costAdd": "",
    "anotherNumber": "",
    "landSize": "",
    "cropsList": "",
    "certificateNumber": "",
    "farmingType": [],
    "contact": "",
  };

  List<String> reqFields = [
    "name",
    "costAdd",
    "landSize",
    "cropList",
    "certificateNumber",
    "darmingType",
    "contact"
  ];

  ////   SOME METHODS //////////

  bool validForm() {
    for (String x in reqFields) {
      if ((data[x].toString()).length == 0) {
        print("validation: false");
        return false;
      }
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
      if (organicCheck)
        farmingType.add("Organic");
      else
        farmingType.remove("Organic");

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
        msg: "First verify your Contact in previous step",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
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
                  "Name*", // labeltext
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
                  "Cost Add*", "", false, // isPassword
                  (val) {
                    data["costAdd"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                CustomTextField(
                  "Another number", "", false, // isPassword
                  (val) {
                    data["anotherNumber"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                CustomTextField(
                  "Land Size*", "", false, // isPassword
                  (val) {
                    data["landSize"] = val;
                  },
                ),

                new SizedBox(
                  height: 30.0,
                ),

                // //////// CROPS YOU GROW ////////

                CustomTextField(
                  "Crops you grow*", "", false, // isPassword
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
                    "If you grow rice and wheat, enter rice,wheat",
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
                    "Choose you farming type*",
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
                      "Organic",
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
                  ],
                ),

                new Row(
                  children: <Widget>[
                    new Text(
                      "Inrganic",
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

                CustomTextField(
                  "Certificate Number*",
                  "",
                  false,
                  (val) {
                    data["certificateNumber"] = val;
                  },
                ),

                new SizedBox(
                  height: 10.0,
                ),

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
                          Color(0xff55ce23),
                          Color(0xffbefd32),
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
