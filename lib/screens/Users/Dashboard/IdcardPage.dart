import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share/share.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class IdCardPage extends StatefulWidget {
  final MainModel model;
  const IdCardPage({Key key,this.model}) : super(key: key);

  @override
  _IdCardPageState createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
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
  final Completer<InAppWebViewController> _controller1 =
  Completer<InAppWebViewController>();

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(

        useShouldOverrideUrlLoading: true,

        javaScriptCanOpenWindowsAutomatically: true,
        mediaPlaybackRequiresUserGesture: false,
        disableHorizontalScroll: true,
        disableVerticalScroll: true,
      ),
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
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      )
    /*android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      loadWithOverviewMode: true,
      useWideViewPort: false,
      builtInZoomControls: false,
      domStorageEnabled: true,
      supportMultipleWindows: true,

    ),*/
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Center(
              child: Text(
                'Id Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
            //Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right:70.0),
                child: InkWell(
                  onTap: () {
    _onShareWithEmptyFields(context); 
                  //  Share.share('https://ehealthsystem.com/download-ehealthcard?userid='+id);

                    //Navigator.pushNamed(context, "/qrcode");
                  },
                  child: Icon(Icons.share),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right:70.0),
                child: InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, "/qrcode");
                  },
                  child: Icon(Icons.share),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                },
                child: Icon(Icons.download),

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
      body:Builder(builder: (BuildContext context) {
        print("api......"+'https://ehealthsystem.com/download-ehealthcard?userid='+id);
        return  Container(
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
       // width: MediaQuery.of(context).size.height,
        child: InAppWebView(

          initialUrlRequest: URLRequest(url: Uri.parse('https://ehealthsystem.com/download-ehealthcard?userid='+id/*"https://www.google.com/search?client=firefox-b-d&q=pdf+example"*/)),
          initialOptions: _options,

          shouldOverrideUrlLoading: (controller, action) {
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

      /*Container(
    height: height,
    child: InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse('https://ehealthsystem.com/download-ehealthcard?userid='+id)),
      initialOptions: _options,
      shouldOverrideUrlLoading: (controller, action) {
        print("override");
        return Future.value(NavigationActionPolicy.ALLOW);
      },
      onWebViewCreated: (webViewController) {
        _controller1.complete(webViewController);
      },
      onDownloadStart: (controller, uri) {
        print("download");
      },
    *//*initialOptions: InAppWebViewGroupOptions(

      crossPlatform: InAppWebViewOptions(
    supportZoom: false,
    javaScriptEnabled: true,
    disableHorizontalScroll: true,
    disableVerticalScroll: true,
    ),
    ),*//*
    )
      ),*/
      /* Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        padding: EdgeInsets.symmetric(horizontal: 0),
        child:
        WebView(

          initialUrl: 'https://ehealthsystem.com/download-ehealthcard?userid='+id,
          //String  url= initialUrl.toString();

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
      ),*/
    );
  }

  _onShareWithEmptyFields(BuildContext context) async {
    await Share.share('https://ehealthsystem.com/download-ehealthcard?userid='+id);
  }
}
