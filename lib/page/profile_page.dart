import 'package:flutter/material.dart';
import 'package:organic/widget/container_with_bordertext.dart';
import 'package:organic/widget/feature_text.dart';
import 'package:organic/widget/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // First Container

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
                  Row(
                    children: <Widget>[
                      Text(
                        "Profile",
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
                      ProfilePic(),
                      new SizedBox(
                        width: 40,
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            " Hello,",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          new SizedBox(
                            height: 10,
                          ),
                          new Text(
                            "Mukesh",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FeatureText(
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    20, // indent
                    MediaQuery.of(context).size.width * 0.4, // endindent
                  ),
                  FeatureText(
                    Text(
                      "Fertility Graph",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    20, // indent
                    MediaQuery.of(context).size.width * 0.4, // endindent
                  ),
                  FeatureText(
                    Text(
                      "Current Rates",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    20, // indent
                    MediaQuery.of(context).size.width * 0.4, // endindent
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "+",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 30.0,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Add New",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
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
              padding: EdgeInsets.all(10),
              child: ContainerWithBorderText(
                Center(
                  // child
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        "Coupons",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 2,
                        indent: MediaQuery.of(context).size.width * 0.19,
                        endIndent: MediaQuery.of(context).size.width * 0.19,
                      ),
                      Text(
                        "News",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
                "Other Analysis", // borderText
              ),
            ),
          ],
        ),
      ),
    );
  }
}
