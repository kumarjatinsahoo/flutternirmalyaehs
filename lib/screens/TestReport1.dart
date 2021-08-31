
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestReport1 extends StatefulWidget {
  MainModel model;

  TestReport1({Key key, this.model}) : super(key: key);

  @override
  _TestReport1State createState() => _TestReport1State();
}

class _TestReport1State extends State<TestReport1> {
  // LoginResponse1 loginResponse;

  String pdfUrl;

  @override
  void initState() {
    //loginResponse = widget.model.loginResponse1;
    super.initState();
    //pdfUrl = widget.model.pdfUrl.replaceAll("http", "https");
    //pdfUrl = "https://docs.google.com/viewer?url=https://ehealthsystem.com/user/view-patient-test-report-pdf-download?id=OTEyMTk5ODA5NTQxMzMwOQ==";
    //pdfUrl = "http://docs.google.com/gview?embedded=true&url=https://ehealthsystem.com/user/view-patient-test-report-pdf-download?id=OTEyMTk5ODA5NTQxMzMwOQ==";
    //pdfUrl = "https://docs.google.com/viewer?url=" + widget.model.pdfUrl;
    pdfUrl = "https://docs.google.com/gview?embedded=true&url=" + widget.model.pdfUrl;
    print(">>>>>>PDF URL TEST REPORT????>>" + pdfUrl);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        /*title: Text(
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),*/
        title: Text(
          "Test Report of "+(widget.model.pdfUrlUser??""),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body: WebView(
        initialUrl: pdfUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
