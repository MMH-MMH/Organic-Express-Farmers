import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:organic/methods/showdailog.dart';
import 'package:organic/services/authservice.dart';
import 'package:organic/widget/accountinfo.dart';
import 'package:organic/widget/container_with_bordertext.dart';
import 'package:organic/widget/feature_text.dart';
import 'package:organic/widget/loader.dart';
import 'package:organic/widget/navbar.dart';
import 'package:organic/widget/profile_pic.dart';
import 'package:organic/widget/profile_pic_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/widget/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  LocalStorage storage = LocalStorage('organic');

  final GlobalKey _scaffoldKey = new GlobalKey();

  var userData;
  String contact;

  bool infoloading = true;

  List<Map<String, dynamic>> order, procuredCrops;

  Widget statusWidget, cropStatusWidget;

  bool loadingStatus = true, loadingCropStatus = true;

  TextStyle statusHead = TextStyle(color: Colors.teal, fontSize: 20);
  TextStyle tableHead = TextStyle(color: Colors.black87, fontSize: 18);

  getDataRow(val) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(val["name"].toString())),
        DataCell(Text(val["status"].toString())),
      ],
    );
  }

  getqtyDataRow(val) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(val["name"].toString())),
        DataCell(Text(val["quantity"].toString())),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    contact = storage.getItem('contact');
    procuredCrops = [
      {"name": "Crop1", "quantity": 0},
      {"name": "Crop2", "quantity": 0},
      {"name": "Crop3", "quantity": 0}
    ];

    if (!Methods().isAuthenticated()) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => NotRegisteredDialogMethod().check(context));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingStatus = false;
          statusWidget = (Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(AppLocalizations.of(context).quantityOfCrops,
                  style: statusHead),
              SizedBox(height: 20),
              SizedBox(height: 2),
              DataTable(
                columns: [
                  DataColumn(label: Text(AppLocalizations.of(context).crop)),
                  DataColumn(
                      label: Text(AppLocalizations.of(context).quantity)),
                ],
                rows: List.generate(
                  procuredCrops.length,
                  (index) => getqtyDataRow(procuredCrops[index]),
                ),
              ),
              SizedBox(height: 10),
            ],
          ));
        });

        AuthService().getinfo(contact).then((usr) async {
          print("profile page userData -- $usr");
          setState(
            () {
              userData = usr['data'];
              infoloading = false;
              // for (int i = 0; i < userData.length; i++) {
              //   String s = userData[i]["status"];
              //   s = s[0].toUpperCase() + s.substring(1);
              //   userData[i]["status"] = s;
              // }
            },
          );
          AuthService().getCropStatus(contact).then((res) {
            print("profile page -- $res");

            setState(() {
              if (res.length > 0) {
                cropStatusWidget = (Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(AppLocalizations.of(context).yourCropStatus,
                        style: statusHead),
                    SizedBox(height: 20),
                    DataTable(
                      columns: [
                        DataColumn(
                            label: Text(AppLocalizations.of(context).crop)),
                        DataColumn(
                            label: Text(AppLocalizations.of(context).status)),
                      ],
                      rows: List.generate(
                        res.length,
                        (index) => getDataRow(res[index]),
                      ),
                    ),
                  ],
                ));
              } else {
                cropStatusWidget =
                    Text(AppLocalizations.of(context).youDontHaveCrops);
              }
              loadingCropStatus = false;
            });
          });
        });
        print("getCropStatusHere -- $contact");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loadingCropStatus
        ? Loader()
        : new Scaffold(
            key: _scaffoldKey,
            drawer: Navbar(),
            body: SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // First Container
                  SizedBox(height: 40),
                  new Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[100],
                    ),
                    padding: EdgeInsets.all(20),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.white,
                          leading: Builder(builder: (BuildContext context) {
                            return new GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: new Container(
                                child: new Icon(Icons.menu, color: Colors.teal),
                              ),
                            );
                          }),
                          primary: false,
                          title: SearchBar(),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).profile,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20.0,
                          thickness: 2,
                          indent: 2,
                          endIndent: MediaQuery.of(context).size.width * 0.5,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            ProfilePic(contact),
                            new SizedBox(
                              width: 40,
                            ),
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  AppLocalizations.of(context).hello("") + ",",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  storage.getItem('name'),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        ////// ACCOUNT INFO ///////

                        infoloading
                            ? Text(AppLocalizations.of(context).loading)
                            : AccountInfo(userData),
                      ],
                    ),
                  ),

                  // Status Container

                  new Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[100],
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(10),
                    child: ContainerWithBorderText(
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              loadingCropStatus
                                  ? Text(AppLocalizations.of(context).loading)
                                  : cropStatusWidget,
                              SizedBox(height: 10),
                              loadingStatus
                                  ? Text(AppLocalizations.of(context).loading)
                                  : statusWidget
                            ],
                          ),
                        ),
                      ),
                      AppLocalizations.of(context).status, // borderText
                    ),
                  ),

                  // Other Analysis Container

                  new Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[100],
                    ),
                    padding: EdgeInsets.all(10),
                    child: ContainerWithBorderText(
                      Center(
                        // child
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/my_orders');
                              },
                              child: Text(
                                AppLocalizations.of(context).myOrders,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Divider(
                              height: 30.0,
                              thickness: 2,
                              indent: MediaQuery.of(context).size.width * 0.19,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.19,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/your_rewards');
                              },
                              child: Text(
                                AppLocalizations.of(context).myRewards,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            SizedBox(height: 70),
                          ],
                        ),
                      ),
                      AppLocalizations.of(context).others, // borderText
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
