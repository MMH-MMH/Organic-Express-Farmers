import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:organic/dialogBoxes/notifications.dart';
import 'package:organic/page/ecommerce/customer_profile.dart';
import 'package:organic/page/ecommerce/main_page.dart';
import 'package:organic/page/ecommerce/search_bar_home.dart';
import 'package:organic/widget/carousel_indicator.dart';
import 'package:organic/widget/horizontal_list_view.dart';
import 'package:organic/widget/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:organic/widget/show_dialog.dart';

class ShopHome extends StatefulWidget {
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  Widget widgetToShow = ConsumerMain();

  showNotifications() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(NotificationDialogBox());
      },
    );
  }

  bool home = true, notify = false, drop = false, person = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus.unfocus()},
      child: Scaffold(
        drawer: Navbar(),
        primary: false,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
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
                        title: SearchBarHome(),
                        shadowColor: Color.fromARGB(0, 255, 255, 255),
                      ),
                      widgetToShow,
                    ],
                  ),
                ),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                    ),
                    color: Colors.teal,
                  ),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      (home == false)
                          ? FooterIcon(
                              Icon(Icons.home),
                              () {
                                setState(() {
                                  widgetToShow = ConsumerMain();
                                  home = true;
                                  notify = false;
                                  drop = false;
                                  person = false;
                                });
                              },
                            )
                          : FooterButton(
                              "Home",
                              Icon(
                                Icons.home,
                                color: Colors.teal,
                              ),
                            ),
                      (notify == false)
                          ? FooterIcon(
                              Icon(Icons.notifications),
                              () {
                                setState(() {
                                  widgetToShow = CustomerProfile();
                                  home = false;
                                  notify = true;
                                  drop = false;
                                  person = false;
                                });
                              },
                            )
                          : FooterButton(
                              "Notify",
                              Icon(
                                Icons.notifications,
                                color: Colors.teal,
                              ),
                            ),
                      (drop == false)
                          ? FooterIcon(
                              Icon(Icons.pin_drop),
                              () {
                                setState(() {
                                  widgetToShow = ConsumerMain();
                                  home = false;
                                  notify = false;
                                  drop = true;
                                  person = false;
                                });
                              },
                            )
                          : FooterButton(
                              "Drop",
                              Icon(
                                Icons.pin_drop,
                                color: Colors.teal,
                              ),
                            ),
                      (person == false)
                          ? FooterIcon(
                              Icon(Icons.person),
                              () {
                                setState(() {
                                  widgetToShow = CustomerProfile();
                                  home = false;
                                  notify = false;
                                  drop = false;
                                  person = true;
                                });
                              },
                            )
                          : FooterButton(
                              "Person",
                              Icon(
                                Icons.person,
                                color: Colors.teal,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterIcon extends StatefulWidget {
  FooterIcon(this.icon, this.onpressed);
  final Icon icon;
  var onpressed;
  _FooterIconState createState() => _FooterIconState();
}

class _FooterIconState extends State<FooterIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.icon,
      color: Colors.white,
      onPressed: widget.onpressed,
    );
  }
}

class FooterButton extends StatefulWidget {
  FooterButton(this.title, this.icon);
  final String title;
  final Icon icon;
  _FooterButtonState createState() => _FooterButtonState();
}

class _FooterButtonState extends State<FooterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: widget.icon,
      label: Text(
        widget.title,
        style: TextStyle(color: Colors.teal),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        primary: Colors.white,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
