import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class TestReport extends StatefulWidget {
  MainModel model;

  TestReport({Key key, this.model}) : super(key: key);

  @override
  _TestReportState createState() => _TestReportState();
}

class _TestReportState extends State<TestReport> {
  // LoginResponse1 loginResponse;

  String pdfUrl;

  @override
  void initState() {
    //loginResponse = widget.model.loginResponse1;
    super.initState();
    pdfUrl = "https://docs.google.com/viewer?url="+widget.model.pdfUrl;
    print(">>>>>>PDF URL TEST REPORT????>>" + pdfUrl);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WebviewScaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        /*title: Text(
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),*/
        title: Text(
          "Test Report",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      url: pdfUrl,
      withZoom: true,
      useWideViewPort: false,
      displayZoomControls: true,
      withJavascript: true,
      clearCache: true,
      clearCookies: true,
    );
  }
}
