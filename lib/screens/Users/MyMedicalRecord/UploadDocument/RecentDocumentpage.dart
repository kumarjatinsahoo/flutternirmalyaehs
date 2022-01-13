import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class RecentDocumentimage extends StatefulWidget {
  MainModel model;

  RecentDocumentimage({Key key, this.model}) : super(key: key);

  @override
  _RecentDocumentimageState createState() => _RecentDocumentimageState();
}

class _RecentDocumentimageState extends State<RecentDocumentimage> {
  LoginResponse1 loginResponse;
  String pdfurl;

  @override
  void initState() {
    loginResponse = widget.model.loginResponse1;
    pdfurl=widget.model.recentpdfurl;
    print("rreeecennttPPPPPPPPPPPPPPPPDDDDDDDDDFFFFFF"+pdfurl);
    super.initState();
    // print(ApiFactory.REPORT_URL+loginResponse.ashadtls[0].reg_no);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      // clearCookies: true,
      // clearCache: true,
      appBar: AppBar(
        title: Text(
          "Image",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body: Image.network(
        pdfurl,
        //color: AppData.kPrimaryColor,
        // height: 50,
      ),
      //  url: ApiFactory.REPORT_URL+loginResponse.ashadtls[0].reg_no,
      //url:widget.model.pdfurl,
      // withZoom: true,
      // scrollBar: true,
      // useWideViewPort: false,
      // displayZoomControls: true,
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
