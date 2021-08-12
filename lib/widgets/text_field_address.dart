import 'package:flutter/material.dart';


class TextFieldAddress extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldAddress({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
      child: Container(
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black,width: 0.3)),
        child: child,
      ),
    );
  }
}
