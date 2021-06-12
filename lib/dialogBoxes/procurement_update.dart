// update crop status

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:organic/methods/showdailog.dart';
import 'package:organic/services/authservice.dart';
import 'package:organic/widget/dropdown.dart';
import 'package:organic/widget/loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProcurementUpdateDialogBox extends StatefulWidget {
  ProcurementUpdateDialogBoxState createState() =>
      new ProcurementUpdateDialogBoxState();
}

class ProcurementUpdateDialogBoxState
    extends State<ProcurementUpdateDialogBox> {
  LocalStorage storage = LocalStorage('organic');
  var contact, userData;
  bool infoloading = true;
  Widget mainWidget;
  List<String> status, status1;
  var statusType;
  List<dynamic> diseases = ['none', 'D1', 'D2', 'D3', 'D4'], crops;

  List<Map<String, dynamic>> cropStatus;

  String rice = "none", wheat = "none", submitText = "Submit";

  // Map<String, String> data;

  @override
  void initState() {
    super.initState();
    // data["temp"] = "none";
    status = [
      'None',
      'Sprout',
      'Seedling',
      'Vegetative',
      'Budding',
      'Flowering',
      'Ripening'
    ];
    status1 = status;
    contact = storage.getItem('contact');
    if (!Methods().isAuthenticated()) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => NotRegisteredDialogMethod().check(context));
    } else {
      AuthService().getinfo(contact).then((res) async {
        setState(
          () {
            userData = res['data'];
            print(" ------ Crops ---- \n $userData");
            statusType = {};
            crops = userData["cropsList"].toList();
            print(" ------ Crops ---- \n $crops");

            for (String crop in crops) {
              statusType[crop] = 'none';
            }
          },
        );

        setState(() {
          infoloading = false;
        });
      });
    }
  }

  void updateStatus() {
    setState(() {
      submitText = AppLocalizations.of(context).sending;
    });
    cropStatus = [
      {"name": "Rice", "status": rice},
      {"name": "Wheat", "status": wheat}
    ];
    contact = storage.getItem('contact');
    var data = {"contact": contact, "cropStatus": cropStatus};
    var res = AuthService().updateStatus(data).then((res) {
      setState(() {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).done,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.grey[500],
          fontSize: 10,
        );
        submitText = AppLocalizations.of(context).submit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return infoloading
        ? Loader()
        : new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                // child:
                child: infoloading
                    ? Text(
                        AppLocalizations.of(context).loading,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(AppLocalizations.of(context).yourCropStatus),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(AppLocalizations.of(context).crop),
                              Text(AppLocalizations.of(context).status),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Rice"),
                              Dropdown(
                                [
                                  'none',
                                  'sprout',
                                  'seedling',
                                  'vegetative',
                                  'budding',
                                  'flowering',
                                  'ripening'
                                ],
                                (String newValue) {
                                  setState(() {
                                    rice = newValue;
                                  });
                                },
                                rice,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Wheat"),
                              Dropdown(
                                [
                                  'none',
                                  'sprout',
                                  'seedling',
                                  'vegetative',
                                  'budding',
                                  'flowering',
                                  'ripening'
                                ],
                                (String newValue) {
                                  setState(() {
                                    wheat = newValue;
                                  });
                                },
                                wheat,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: <Widget>[
                          //     Text("Temp"),
                          //     StatusDropdown(data["temp"]),
                          //   ],
                          // ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: updateStatus,
                            child: Text(
                              submitText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                            ),
                          )
                        ],
                      ),
              ),
            ],
          );
  }
}
