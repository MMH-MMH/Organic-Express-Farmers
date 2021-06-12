import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((AnimationStatus status) {});
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              child: ClipRRect(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      // getImage();
                    },
                    child: Image.asset(
                      'assets/logo.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.teal,
              height: 3.0,
              width: animation.value * 100.0,
            ),
            SizedBox(height: 2),
            Container(
              color: Colors.teal,
              height: 3.0,
              width: animation.value * 75.0,
            ),
            SizedBox(height: 2),
            Container(
              color: Colors.teal,
              height: 3.0,
              width: animation.value * 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
