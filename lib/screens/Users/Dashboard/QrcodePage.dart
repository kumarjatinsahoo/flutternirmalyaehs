import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class QrcodePage extends StatefulWidget {
  final MainModel model;

  const QrcodePage({Key key, this.model}) : super(key: key);

  @override
  _QrcodePageState createState() => _QrcodePageState();
}

class _QrcodePageState extends State<QrcodePage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  String id;
  LoginResponse1 loginResponse1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    id = base64.encode(utf8.encode(loginResponse1.body.user));
    print("<<<<<<<<user>>>>>>>>" + loginResponse1.body.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr code"),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              alignment: Alignment.center,
              child: Expanded(
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: QrImage(
                  data: loginResponse1.body.user?? "0",
                  version: QrVersions.auto,
                  //size: 190.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  /*decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white),*/
                padding: EdgeInsets.only(bottom: 100),
                  child:Text(loginResponse1.body.user)
               /* child: Image.asset(
                  "assets/logo1.png",
                  width: 50,
                  height: 50,
                  color: Colors.black,
                ),*/
              ),
            ),
          ],
        ),
      ),
    );
  }
}
