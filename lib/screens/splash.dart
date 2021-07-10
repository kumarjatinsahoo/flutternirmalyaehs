import 'dart:async';
import 'dart:convert';
import 'package:user/providers/SharedPref.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    callResourceTimer();
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
                        "assets/logo1.png",
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
    Navigator.pushNamed(context, "/login");
  }
}
