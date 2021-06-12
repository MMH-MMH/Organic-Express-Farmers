import 'package:flutter/material.dart';

class ContainerWithBorderText extends StatefulWidget {
  ContainerWithBorderText(this.child, this.borderText);
  final Widget child;
  final String borderText;
  ContainerWithBorderTextState createState() =>
      new ContainerWithBorderTextState();
}

class ContainerWithBorderTextState extends State<ContainerWithBorderText> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: EdgeInsets.only(bottom: 10, top: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400], width: 1),
            borderRadius: BorderRadius.circular(0),
            shape: BoxShape.rectangle,
          ),
          child: widget.child,
        ),
        Positioned(
          left: 30,
          top: 8,
          child: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: Colors.grey[100],
            child: Text(
              widget.borderText,
              style: TextStyle(color: Colors.teal, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

/*

Child: 

new 
*/
