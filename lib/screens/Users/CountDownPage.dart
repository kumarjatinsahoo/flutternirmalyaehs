import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/Buttons.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return new Text(
      (animation.value.toString() == "0") ? "SENT" : animation.value.toString(),
      style: new TextStyle(
          fontSize: (animation.value.toString() == "0") ? 100 : 150.0,
          color: AppData.kPrimaryRedColor,
          fontWeight: FontWeight.w500),
    );
  }
}

class CountDownPage extends StatefulWidget {
  MainModel model;

  CountDownPage({Key key, this.model});

  State createState() => new _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  static const int kStartValue = 4;
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );
    _controller.forward(from: 0.0).whenComplete(() {
      AppData.showInSnackBar(context, "Done");
      setState(() {
        isComplete = true;
      });
    });
  }
  sentToServer(){
   // widget.model.POSTMETHOD(api: api, json: json, fun: fun)
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.play_arrow),
        onPressed: () => _controller.forward(from: 0.0),
      ),*/
      bottomNavigationBar: Buttons.downloadButton(
          title: "Cancel",
          context: context,
          function: () {
            Navigator.pop(context);
          }),
      body: new Container(
        child: new Center(
          child: new Countdown(
            animation: new StepTween(
              begin: kStartValue,
              end: 0,
            ).animate(_controller),
          ),
        ),
      ),
    );
  }
}
