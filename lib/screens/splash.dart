import 'dart:async';
import 'dart:convert';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  final MainModel model;

  const SplashScreen({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref sharedPref = SharedPref();
  bool isFirstTym = true;

  @override
  void initState() {
    super.initState();
    callResourceTimer();
  }

  Future<Null> isFirstTimes() async {
    String isFirstTime = await sharedPref.getKey('first_time');
    if (isFirstTime != null) {
      if (isFirstTime.replaceAll("\"", "") == "false") {
        callResourceTimer();
        setState(() => isFirstTym = false);
      } else {
        setState(() => isFirstTym = true);
      }
    } else {
      setState(() => isFirstTym = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Image.asset(
                        //"assets/logo_matru.png",
                        "assets/images/eHealthlogo1.png",
                        fit: BoxFit.fitWidth,
                        //width: 120,
                        height: 210.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Text(
                        "Matrujyoti",
                        style: TextStyle(
                            color: AppData.kPrimaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )*/
                  ],
                ),
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  "assets/mobile_bg.png",
                  fit: BoxFit.fitWidth,
                  height: 140,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void callResourceTimer() {
    Timer(Duration(seconds: 5), navigationPage);
  }
  void navigationPage() async {
    //Navigator.of(context)
    //.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    Navigator.of(context).pushReplacementNamed('/login');

    SharedPref sharedPref = SharedPref();
    var login = await sharedPref.getKey(Const.IS_LOGIN);
    if (login != null) {
      String isLogin = await sharedPref.read(Const.IS_LOGIN);
      if (isLogin == Const.TRUE) {
        //widget.model.dashData(loginData.referenceNo);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
    }
  }
  /*void navigationPage() async {
    if (isFirstTym) {
      Navigator.pushNamed(context, "/intro");
    } else {
      Navigator.pushNamed(context, "/login");
    }
  }*/
}
