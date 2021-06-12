import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Icard extends StatefulWidget {
  Icard(this.title, this.imgurl);
  final String title, imgurl;
  _IcardState createState() => _IcardState();
}

class _IcardState extends State<Icard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Card(
        child: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              Image.network(
                widget.imgurl,
                // width: 300,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              Text(
                "I am",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
