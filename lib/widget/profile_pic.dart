import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ProfilePic extends StatefulWidget {
  ProfilePicState createState() => new ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(75.0),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/profile_page");
          },
          child: Image.network(
            '1.jpeg',
            // width: 300,
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
