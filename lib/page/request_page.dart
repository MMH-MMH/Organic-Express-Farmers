import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:organic/widget/container_with_bordertext.dart';

import 'package:organic/widget/profile_pic.dart';
import 'package:organic/widget/request_list_child.dart';
import 'package:organic/widget/search_bar.dart';

class RequestPage extends StatefulWidget {
  RequestPageState createState() => RequestPageState();
}

class RequestPageState extends State<RequestPage> {
  String contact, name;

  LocalStorage storage = LocalStorage('organic');

  void logout() {
    storage.deleteItem('name');
    storage.deleteItem('contact');
    Navigator.of(context).pushNamed("/");
  }

  void check() {
    print("Check $contact");
    if (contact == null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Your contact is not registered yet",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        child: Text("Click here to register"),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register_page');
                        }),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    name = storage.getItem('name');

    name = (name == null) ? "username" : name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.all(20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: logout,
                      tooltip: "Logout",
                    ),
                  ),

                  // Search Bar
                  SearchBar(),

                  SizedBox(
                    height: 10,
                  ),

                  Center(
                    child: ProfilePic(),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Pop-up List Container

                  ContainerWithBorderText(
                    RequestList(),
                    "Request", // Border Text
                  ),
                ],
              ),
            ),

            // Second Container

            new Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Crop Doctor",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Center(
                    child: Text(
                      "Resources",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Center(
                    child: Text(
                      "Help Desk",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                ],
              ),
            ),
            // ((storage.getItem('name') == null)
            //     ? (Navigator.of(context).pushNamed('/register_page'))
            //     : (SizedBox(height: 1))),
          ],
        ),
      ),
    );
  }
}
