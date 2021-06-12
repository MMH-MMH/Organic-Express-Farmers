import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  double an = 0;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: new Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = new CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
    animation.addListener(() {
      this.setState(() {});
    });
    animation.addStatusListener((AnimationStatus status) {
      this.setState(() {
        an = animation.value;
        an = (an < 0) ? (an * -1) : an;
      });
    });
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
            new Container(
              color: Colors.teal,
              height: 3.0,
              width: animation.value * 100.0,
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 5.0),
            ),
            new Container(
              color: Colors.teal,
              height: 3.0,
              width: animation.value * 75.0,
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 5.0),
            ),
            new Container(
              color: Colors.teal,
              height: 3.0,
              width: ((animation.value < 0)
                      ? (-1 * animation.value)
                      : (animation.value)) *
                  50.0,
            ),
          ],
        ),
      ),
    );
  }
}
