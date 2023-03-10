import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class UserMedicineUrl extends StatefulWidget {
  final MainModel model;
  const UserMedicineUrl({Key key,this.model}) : super(key: key);

  @override
  _UserMedicineUrlState createState() => _UserMedicineUrlState();
}

class _UserMedicineUrlState extends State<UserMedicineUrl> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  String id;
  LoginResponse1 loginResponse1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    id=base64.encode(utf8.encode(loginResponse1.body.user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine"),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:
        WebView(
         // initialUrl: 'https://ehealthsystem.com/download-ehealthcard?userid='+id,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),

        // child:
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image.asset("assets/images/healthCard.jpeg"),
        //     Divider(),
        //     Image.asset("assets/images/healthCard2.jpeg"),
        //   ],
        // ),
      ),
    );
  }
}
