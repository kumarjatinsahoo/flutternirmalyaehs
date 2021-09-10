import 'package:flutter/material.dart';
class IdCardPage extends StatefulWidget {
  const IdCardPage({Key key}) : super(key: key);

  @override
  _IdCardPageState createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Id Card"),
      ),
      body: Center(
        child: Image.asset("assets/images/healthCard.jpeg"),
      ),
    );
  }
}
