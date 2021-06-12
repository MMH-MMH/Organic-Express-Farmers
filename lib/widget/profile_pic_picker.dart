import 'package:organic/page/profile_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:localstorage/localstorage.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic(this.contact);
  final String contact;
  ProfilePicState createState() => new ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  LocalStorage storage = LocalStorage('organic');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  ProfilePage();
                },
                child: Image.network(
                  'https://static.thenounproject.com/png/3237155-200.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
