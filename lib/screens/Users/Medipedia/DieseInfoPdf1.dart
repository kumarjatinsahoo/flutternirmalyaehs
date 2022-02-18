import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
//import 'package:matrujyoti/models/LoginResponse.dart';

class DieseInfoPdf1 extends StatefulWidget {
  MainModel model;

  DieseInfoPdf1({Key key, this.model}) : super(key: key);

  @override
  _DieseInfoPdf1State createState() => _DieseInfoPdf1State();
}

class _DieseInfoPdf1State extends State<DieseInfoPdf1> {
  LoginResponse1 loginResponse;
  String diese;
  InAppWebViewController webView;
  double progress = 0;

  @override
  void initState() {
    loginResponse = widget.model.loginResponse1;
    diese=widget.model.diesepdf;
    print("PPPPPPPPPPPPPPPPDDDDDDDDDFFFFFF"+diese);
    super.initState();
    // print(ApiFactory.REPORT_URL+loginResponse.ashadtls[0].reg_no);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    webView.clearCache();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      // clearCache: true,
      // clearCookies: true,
      appBar: AppBar(
        /*title: Text(
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),*/
        title: Text(MyLocalizations.of(context).text("PDF"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),

/*       url:'https://docs.google.com/viewer?url='+widget.model.diesepdf,
      withZoom: true,
      useWideViewPort: false,
      displayZoomControls: true,*/
    body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF041B33),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xFF041B33),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(diese)),
                    /*initialUrl: ApiFactory.SOCIAL_DETAIL+widget.model.socialType+
                            widget.model.socialRequest,*/
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          userAgent:
                          (Platform.isAndroid) ? "Chrome" : "Safari"
                        //debuggingEnabled: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                      ),
                      /*android: AndroidInAppWebViewOptions(

                            ),
                            ios: IOSInAppWebViewOptions(

                            )*/
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (controller, Uri url) {
                      setState(() {
                        //log("Path>>>"+url);
                        //this.url = url;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      // log("Console msg>>" + consoleMessage.message);
                    },
                    /*  onLoadResource: (InAppWebViewController controller,LoadedResource res){
                          log("Resource>>>>"+res.url.query);
                        },
                        onPrint: (InAppWebViewController controller, Uri url) {
                          log("Resource>>>>"+url.query);
                          if (url.query.contains("accessToken")) {
                            */ /*print("mobilePaymentStatus>>>>>>>>>>");
                            controller
                                .evaluateJavascript(
                                    source:
                                        "document.getElementById('hiddenData').innerHTML")
                                .then((value) {
                              Map<String, dynamic> res = json
                                  .decode(value.replaceAll(RegExp("'"), ''));
                              print(res['PaymentStatus']);
                              Navigator.pop(context, res);
                            });*/ /*
                            AppData.showInSnackDone(context, "Data Comming");
                          }
                        },*/
                    onLoadStop:
                        (InAppWebViewController controller, Uri url) async {

                    },

                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
            child: progress < 1.0
                ? Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Color(0xFF041B33),
              // color: Colors.white,
              // child: Image.asset("assets/images/logo_data.gif"),
              child: Center(child: CircularProgressIndicator(color: Colors.white,)),
            )
            // ? CircularProgressIndicator(value: progress,)
                : Container(
              // color: ColorsAsset.loginColor,
            )),
      ],
    )
    );
  }

  Widget _buildTile({String icon, String title, String text, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppData.matruColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all( 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Monte",
                      fontSize: 12.0,
                    ),

                  ),
                  SizedBox(height: 10,),
                  Text(text, style: TextStyle(color: Colors.white, fontFamily: "Monte", fontWeight: FontWeight.bold, fontSize: 17),),
                  Spacer(),
                  Image.network(image, fit: BoxFit.cover,
                    height: 60,
                    width: double.infinity,
                  )
                ],
              ),
            ),
            Positioned(
                top: 15,
                right: 15,
                child: Image.asset(icon, height: 10, color: Colors.white,)),
          ],
        ),
      ),
    );
  }


}
