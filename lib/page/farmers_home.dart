import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:organic/methods/showdailog.dart';
import 'package:organic/widget/card.dart';

import 'package:organic/widget/container_with_bordertext.dart';
import 'package:organic/widget/navbar.dart';
import 'package:organic/widget/newscard.dart';
import 'package:organic/widget/profile_pic.dart';

import 'package:organic/widget/profile_pic_picker.dart';
import 'package:organic/widget/request_list_child.dart';
import 'package:organic/widget/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestPage extends StatefulWidget {
  RequestPageState createState() => RequestPageState();
}

class RequestPageState extends State<RequestPage> {
  String contact, name;

  LocalStorage storage = LocalStorage('organic');

  @override
  void initState() {
    if (!Methods().isAuthenticated()) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => NotRegisteredDialogMethod().check(context));
    }
    super.initState();
    name = storage.getItem('name');
    name = (name == null) ? "username" : name;
  }

  final GlobalKey _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Navbar(),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            // Navbar(),
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.all(20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Search Bar

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

                  SizedBox(
                    height: 20,
                  ),

                  Center(
                    child: ShowProfilePic(),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).hello("username") + ",",
                      // "Hello,",
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
                    AppLocalizations.of(context).quickPanel, // Border Text
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
                  MainLink(
                    AppLocalizations.of(context).resources,
                    "/resources",
                  ),
                  LinkDivider(),
                  MainLink(
                    AppLocalizations.of(context).helpDesk,
                    "/help_desk",
                  ),
                  LinkDivider(),
                  MainLink(
                    AppLocalizations.of(context).yourRewards,
                    "/your_rewards",
                  ),
                  LinkDivider(),
                  MainLink(
                    AppLocalizations.of(context).leaderboard,
                    "/leaderboard",
                  ),
                  LinkDivider(),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: <Widget>[
                  Image.network(
                    'https://mms.businesswire.com/media/20180709005392/en/666904/5/5_Basic_Organic_Farming_Methods_You_Might_Not_Have_Known.jpg',
                    // width: 300,
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.85,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: <Widget>[
                  Image.network(
                    'https://www.ugaoo.com/knowledge-center/wp-content/uploads/2017/11/shutterstock_364038656.jpg',
                    // width: 300,
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.85,
                    fit: BoxFit.fill,
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

class MainLink extends StatelessWidget {
  MainLink(this.text, this.url);
  final String text, url;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(this.url);
        },
      ),
    );
  }
}

class LinkDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      thickness: 2,
      indent: 40,
      endIndent: 40,
    );
  }
}
