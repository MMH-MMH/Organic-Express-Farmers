import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:organic/widget/card.dart';

class UserType extends StatefulWidget {
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/register_page");
                      },
                      child: Icard(
                        "Farmer",
                        'https://cdn2.vectorstock.com/i/thumb-large/78/56/farmer-symbol-farm-agriculture-healthy-food-vector-33327856.jpg',
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/shop_home");
                      },
                      child: Icard(
                        "Consumer",
                        'https://cdn3.iconfinder.com/data/icons/e-commerce-2-2/380/1-512.png',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
