import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
class IdCardPage extends StatefulWidget {
  final MainModel model;
  const IdCardPage({Key key,this.model}) : super(key: key);

  @override
  _IdCardPageState createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Id Card"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: WebView(
          initialUrl: 'https://ehealthsystem.com/download-ehealthcard?userid=OTEyMTQ0ODY3NDQwMzQ3Nw==',
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
