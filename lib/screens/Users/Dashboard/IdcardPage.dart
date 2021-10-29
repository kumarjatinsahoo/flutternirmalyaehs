import 'dart:async';
import 'package:flutter/material.dart';
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:
        WebView(
          initialUrl: 'https://ehealthsystem.com/download-ehealthcard?userid='+id,
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
