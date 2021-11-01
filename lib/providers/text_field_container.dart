
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const TextFieldContainer({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(left: 0, right: 0, top: 6.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.only(left: 0,right: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: child,
      ),
    );
  }
}
