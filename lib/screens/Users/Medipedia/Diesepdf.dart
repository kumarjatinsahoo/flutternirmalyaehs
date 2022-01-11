import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
//import 'package:matrujyoti/models/LoginResponse.dart';

class Diesepdf extends StatefulWidget {
  MainModel model;

  Diesepdf({Key key, this.model}) : super(key: key);

  @override
  _DiesepdfState createState() => _DiesepdfState();
}

class _DiesepdfState extends State<Diesepdf> {
  LoginResponse1 loginResponse;
  String diese;

  @override
  void initState() {
    loginResponse = widget.model.loginResponse1;
    diese=widget.model.diesepdf;
   // print("PPPPPPPPPPPPPPPPDDDDDDDDDFFFFFF"+diese);
    super.initState();
    // print(ApiFactory.REPORT_URL+loginResponse.ashadtls[0].reg_no);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WebviewScaffold(
      // backgroundColor: Colors.grey[200],
      clearCache: true,
      clearCookies: true,
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
      //  url: ApiFactory.REPORT_URL+loginResponse.ashadtls[0].reg_no,
       url:'https://docs.google.com/viewer?url='+widget.model.diesepdf,
     // url:'https://docs.google.com/viewer?url=http://api.ehealthsystem.com/nirmalyaRest/document/disease/upper_respiratory_tract_infection.pdf',
      //url:'https://docs.google.com/viewer?url=http://www.africau.edu/images/default/sample.pdf',
      withZoom: true,
      useWideViewPort: false,
      displayZoomControls: true,
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
