import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/services/authservice.dart';
import 'package:organic/widget/dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/widget/loader.dart';

class RequestSeed extends StatefulWidget {
  _RequestSeedState createState() => _RequestSeedState();
}

class _RequestSeedState extends State<RequestSeed> {
  LocalStorage storage = LocalStorage('organic');
  String type = 'Seeds', qty, subType = 'Select Items you want', submitText;
  bool loading = true;
  List<String> selected;
  Map<String, List<String>> typeList, selList;
  int selectLen = 0;

  Map<String, String> data;

  int getLen(String type) {
    List<String> list = typeList[type];
    int len = (list == null ? 0 : list.length);
    if (typeList[type].contains('No items left')) len--;
    return len;
  }

  Widget requestItemsWidget;

  void getTypeList() {
    AuthService().getTypeList('Seeds').then((items) {
      typeList = items;

      subType = typeList['Seeds'][0];

      selList = {'Seeds': [], 'Bio-Fertilizers': []};

      setState(() {
        loading = false;
        // any list should not be zero
      });
    });
  }

  String getType(String item) {
    if (selList['Seeds'].contains(item)) {
      return 'Seeds';
    } else {
      return 'Bio-Fertilizers';
    }
  }

  submit() {
    setState(() {
      submitText = AppLocalizations.of(context).sending;
    });

    if (data == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).enterQtyForall,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
      setState(() {
        submitText = AppLocalizations.of(context).submit;
      });
      return;
    }

    Map<String, String> requests;

    for (String item in selected) {
      if (data[item] == null) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).enterQtyForall,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.red,
          fontSize: 10,
        );
        setState(() {
          submitText = AppLocalizations.of(context).submit;
        });
        return;
      }
      if (data[item] == "") {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).enterQtyForall,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.red,
          fontSize: 10,
        );
        setState(() {
          submitText = AppLocalizations.of(context).submit;
        });
        return;
      }
      if (requests == null) requests = {};
      if (requests[item] == null) requests[item] = "";

      requests[item] = data[item];
    }

    String contact = storage.getItem('contact');

    AuthService().sendRequest([requests, contact]).then((res) {
      setState(() {
        submitText = AppLocalizations.of(context).submit;
      });
    });
  }

  TextStyle loadingStyle = TextStyle(color: Colors.teal, fontSize: 20);

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTypeList();
      setState(() {
        loading = true;
        submitText = AppLocalizations.of(context).submit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          // width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,

          margin: EdgeInsets.symmetric(horizontal: 40),
          child: loading
              ? Loader()
              : (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                AppLocalizations.of(context).selectCategory),
                          ),
                        ),
                        Dropdown(
                          ['Seeds', 'Bio-Fertilizers'],
                          (String newValue) {
                            setState(() {
                              type = newValue;
                              subType = typeList[type][0];
                            });
                          },
                          type,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child:
                                Text(AppLocalizations.of(context).selectType),
                          ),
                        ),
                        Dropdown(
                          typeList[type],
                          (String val) {
                            if (getLen(type) == 0) {
                              // means selected.length > 0
                              setState(() {
                                typeList[type] = ['No items left'];
                              });
                            } else {
                              setState(() {
                                typeList[type].remove(val);
                                if (selList[type] == null) {
                                  selList[type] = [val];
                                } else {
                                  selList[type].add(val);
                                }
                                if (selected == null)
                                  selected = [val];
                                else
                                  selected.add(val);
                                // selected.add(val);
                                selectLen += 1;
                              });
                            }

                            setState(() {
                              if (getLen(type) == 0) {
                                typeList[type] = ['No items left'];
                              }
                              subType = typeList[type][0];
                            });
                          },
                          subType,
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    (selectLen == 0)
                        ? Text(AppLocalizations.of(context).noItemsSelected)
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: selected.map((product) {
                                return TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal),
                                      ),
                                      hintText: (AppLocalizations.of(context)
                                                  .enterQtyFor +
                                              product)
                                          .toString(),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.teal),
                                        onPressed: () {
                                          setState(() {
                                            selectLen -= 1;
                                            selected.remove(product);
                                            String ctype = getType(product);

                                            typeList[getType(product)]
                                                .add(product);
                                            selList[getType(product)]
                                                .remove(product);
                                            if (typeList[ctype]
                                                .contains("No items left")) {
                                              typeList[ctype]
                                                  .remove("No items left");
                                              subType = typeList[type][0];
                                            }
                                          });
                                        },
                                      )),
                                  onChanged: (String val) {
                                    setState(() {
                                      if (data == null) data = {};
                                      if (data[product] == null)
                                        data[product] = "";
                                      data[product] = val;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: Text(
                          submitText,
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: (selectLen > 0) ? submit : null,
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
