import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/ProfileModel1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';

import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/PatientListModel.dart';

class DocMyProfile extends StatefulWidget {
  MainModel model;

  DocMyProfile({Key key, this.model}) : super(key: key);

  @override
  _DocMyProfileState createState() => _DocMyProfileState();
}

class _DocMyProfileState extends State<DocMyProfile> {
  String loAd = "Loading..";
  //Body model;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  ProfileModel1 profileModel1;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
    //model = widget.model.model;
  }
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.USER_PROFILE + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              profileModel1 = ProfileModel1.fromJson(map);

            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  getGender(String gender) {
    switch (gender) {
      case "0":
        return "Male";
        break;
      case "1":
        return "Female";
        break;
      case "3":
        return "Transgender";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                  'My Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //Spacer(),
           /*   Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/qrcode");
                    },
                    child: Icon(Icons.qr_code_outlined),
                  ),
                ),
              ),*/
              /*Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/idCard");
                  },
                  child: Text(
                    "ID CARD",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),*/
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
        /*appBar: AppBar(
          title: Text("User Profile"),
          titleSpacing: 2,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),*/
        body:
         (profileModel1 != null)
             ? Container(
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: AppData.matruColor.withOpacity(0.7),
                      ),
                    ),
                    _buildHeader(context)
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: Text("User Information",
                   // MyLocalizations.of(context).text("USER_INFORMATION").toUpperCase(),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...ListTile.divideTiles(
                              color: Colors.grey,
                              tiles: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: Icon(Icons.calendar_today),
                                  title: Text("BIRTH DATE"),
                                  subtitle: Text(profileModel1.body.birthdate??"N/A"),
                                ), ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: Icon(Icons.person),
                                  title: Text("GENDER"),
                                  subtitle: Text( profileModel1.body.gender??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.book),
                                  title: Text(
                                    "EDUCATION",
                                  ),
                                  subtitle: Text(profileModel1.body.education??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.face),
                                  title: Text(
                                    "SPECIALITY",
                                  ),
                                  subtitle: Text(profileModel1.body.speciality??"N/A"),
                                ),

                                ListTile(
                                  leading: Icon(Icons.email),
                                  title: Text("ORGANIZATION"),
                                  subtitle: Text("NIRMALYA"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.contact_phone),
                                  title: Text("IMA NO"),
                                  subtitle: Text( profileModel1.body.imano??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text(
                                    "PAN CARD NO",
                                  ),
                                  subtitle: Text(profileModel1.body.pancardno),
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text(
                                    "PASSPORT NO",
                                  ),
                                  subtitle: Text(profileModel1.body.passportno??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text(
                                    "VOTER CARD NO",
                                  ),
                                  subtitle: Text(profileModel1.body.votercardno??"N/A"),
                                ), ListTile(
                                  leading: Icon(Icons.filter),
                                  title: Text(
                                    "LICENCE NO",
                                  ),
                                  subtitle: Text(profileModel1.body.licenceno??"N/A"),
                                ),

                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 13,
                )
              ],
            ),
          ),
        )
            : Center(
          child: Text(
            loAd,
            style: TextStyle(color: Colors.black, fontSize: 23),
          ),
        )
    );
  }


  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin:
            EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: const Radius.circular(15.0),
                bottomRight: const Radius.circular(15.0),
              ),
              /*image: DecorationImage(
                  image: AssetImage(
                    "assets/card.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),*/
              /*gradient: LinearGradient(
                  colors: [AppData.matruColor, Colors.black54],
                ),*/
              color: AppData.matruColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height: 45.0,
                ),*/
                Text(
                  profileModel1.body.name??"N/A",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "AADHAAR NO" +
                      ": " +
                      profileModel1.body.aadhaar??"N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(AppData.defaultImgUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
