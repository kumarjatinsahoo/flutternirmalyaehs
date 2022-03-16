import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:share/share.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class GovermentSchemesDitelsPage extends StatefulWidget {
  final MainModel model;
  const GovermentSchemesDitelsPage({Key key,this.model}) : super(key: key);

  @override
  _GovermentSchemesDitelsPageState createState() => _GovermentSchemesDitelsPageState();
}

class _GovermentSchemesDitelsPageState extends State<GovermentSchemesDitelsPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  String id;
  String doctorid;
  String datest;
  LoginResponse1 loginResponse1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1=widget.model.loginResponse1;

    /*    id=base64.encode(utf8.encode(loginResponse1.body.user));
    doctorid=base64.encode(utf8.encode( widget?.model?.doctorst));
    datest=base64.encode(utf8.encode( widget?.model?.meddatest));*/
  }
  final Completer<InAppWebViewController> _controller1 =
  Completer<InAppWebViewController>();

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        javaScriptCanOpenWindowsAutomatically:true,
        mediaPlaybackRequiresUserGesture: false,
        disableHorizontalScroll: false,
        preferredContentMode:UserPreferredContentMode.MOBILE,
        // supportZoom: false,
        disableVerticalScroll: false,
      ),
    android: AndroidInAppWebViewOptions(
      // displayZoomControls: false,
      // builtInZoomControls: false
        textZoom:230
    ), ios: IOSInAppWebViewOptions(
      // displayZoomControls: false,
      // builtInZoomControls: false
      //  pageZoom: 270
    )
  );
/* final Completer<InAppWebViewController> _controller1 =
  Completer<InAppWebViewController>();

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(

        useShouldOverrideUrlLoading: true,
        javaScriptCanOpenWindowsAutomatically: true,
        mediaPlaybackRequiresUserGesture: false,
        disableHorizontalScroll: true,
        disableVerticalScroll: false,
      ),*/
    /*crossPlatform: InAppWebViewOptions(
       //useShouldOverrideUrlLoading: true,
       mediaPlaybackRequiresUserGesture: false,
      // javaScriptEnabled: true,
      //debuggingEnabled: true,
      //preferredContentMode: UserPreferredContentMode.DESKTOP,
      supportZoom: false,
      javaScriptEnabled: true,
      //disableHorizontalScroll: false,
      disableHorizontalScroll: true,
      disableVerticalScroll: true,
    ),*/
  /*    android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      )*/
    /*android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      loadWithOverviewMode: true,
      useWideViewPort: false,
      builtInZoomControls: false,
      domStorageEnabled: true,
      supportMultipleWindows: true,

    ),*/
  /*);*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Center(
              child: Text(
                'Schemes Details',
                style: TextStyle(color: Colors.white),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
        backgroundColor: AppData.kPrimaryColor,
        //centerTitle: true,
        // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
      ),
      body: Builder(builder: (BuildContext context) {
        print(widget.model.pdfurl);
        return Container(
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            // width: MediaQuery.of(context).size.height,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.model.pdfurl)),
              initialOptions: _options,
                onZoomScaleChanged:(c,val,cal1){

                } ,
              shouldOverrideUrlLoading:(controller, action) {
                print("override");
                return Future.value(NavigationActionPolicy.ALLOW);
              },
              onWebViewCreated: (webViewController) {
                _controller1.complete(webViewController);
              },
              onDownloadStart: (controller, uri) {
                print("download");
              },
            ),
          ),
        );
      }),
     /* body:Container(

        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child:WebView(


        initialUrl: "https://demo.ehealthsystem.com/user/mobile-organ-donation-pdf-download?id="+id,
        //String  url= initialUrl.toString();

        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);


        },
      ),

      )*/

    );
  }

  _onShareWithEmptyFields(BuildContext context) async {

    await Share.share("https://ehealthsystem.com/user/mobile-organ-donation-pdf-download?id="+id,);
  }
}
