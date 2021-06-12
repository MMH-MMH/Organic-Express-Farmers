import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  NewsCard(this.title, this.imgurl);
  final String title, imgurl;
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            widget.imgurl,
            // width: 300,
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 20),
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
