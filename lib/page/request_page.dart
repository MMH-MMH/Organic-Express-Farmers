import 'package:flutter/material.dart';
import 'package:organic/widget/container_with_bordertext.dart';
import 'package:organic/widget/feature_text.dart';
import 'package:organic/widget/profile_pic.dart';
import 'package:organic/widget/request_list_child.dart';
import 'package:organic/widget/search_bar.dart';

class RequestPage extends StatefulWidget {
  RequestPageState createState() => RequestPageState();
}

class RequestPageState extends State<RequestPage> {
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
                      "Mukesh,",
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
          ],
        ),
      ),
    );
  }
}
