import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class HealthTipsFB extends StatefulWidget {
  MainModel model;

  HealthTipsFB({Key key, this.model}) : super(key: key);

  @override
  _HealthTipsFBState createState() => _HealthTipsFBState();
}

class _HealthTipsFBState extends State<HealthTipsFB> {
  // LoginResponse1 loginResponse;

  String pdfUrl;

  @override
  void initState() {
    super.initState();
    pdfUrl = "https://www.facebook.com/Health-Tips-112341063598103/?ref=page_internal";
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
          MyLocalizations.of(context).text("HEALTH_TIPS_LIST"),
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
      hidden: true,
      useWideViewPort: false,
      displayZoomControls: true,
      withJavascript: true,
      clearCache: true,
      clearCookies: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
