import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localstorage/localstorage.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:organic/services/authservice.dart';

class ShowProfilePic extends StatefulWidget {
  _ShowProfilePicState createState() => _ShowProfilePicState();
}

class _ShowProfilePicState extends State<ShowProfilePic> {
  LocalStorage storage = LocalStorage('organic');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              // getImage();
            },
            child: Image.network(
              'https://static.thenounproject.com/png/3237155-200.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
