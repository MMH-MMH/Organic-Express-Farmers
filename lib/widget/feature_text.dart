import 'package:flutter/material.dart';

class FeatureText extends StatefulWidget {
  FeatureText(this.feature, this.indent, this.endindent);
  final Widget feature;
  final double indent, endindent;
  FeatureTextState createState() => FeatureTextState();
}

class FeatureTextState extends State<FeatureText> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.feature,
          SizedBox(height: 4),
          Divider(
            height: 2.0,
            thickness: 2,
            indent: widget.indent,
            endIndent: widget.endindent,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
