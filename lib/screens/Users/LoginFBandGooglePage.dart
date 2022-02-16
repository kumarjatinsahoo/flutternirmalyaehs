import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/EmergencyHelpModel.dart';
import 'package:user/models/EmergencyMessageModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/UpdateEmergencyModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';


class LoginFBandGooglePage extends StatefulWidget {
  MainModel model;

  LoginFBandGooglePage({Key key, this.model}) : super(key: key);

  @override
  _LoginFBandGooglePageState createState() => _LoginFBandGooglePageState();
}

class _LoginFBandGooglePageState extends State<LoginFBandGooglePage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Codesundar"),
      ),
      body:  Container(
        child: Column(
          children: [
            GestureDetector(
             onTap: (){

             },
            child:Container(
              height: 55,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                border:Border.all(color: Color(0xff39579A)) ,
                  /*color: Color(0xff39579A), */borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/fb_logo.png",
                        height: 30,
                      //width: MediaQuery.of(context).size.width * 0.10,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('Login with Facebook',
                        style: TextStyle(
                            color:Color(0xff39579A),
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),),
      GestureDetector(
          onTap: (){

          },
           child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color(0xffDF4A32), borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/changepassword.png",
                      height: 30,
                      //width: MediaQuery.of(context).size.width * 0.10,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('Login with Google',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),),
        ]
      ),
      ),
    );
  }
}
