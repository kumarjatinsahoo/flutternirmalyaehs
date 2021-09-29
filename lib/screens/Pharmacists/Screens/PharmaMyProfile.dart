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


class PharmaMyProfile extends StatefulWidget {
  MainModel model;

  PharmaMyProfile({Key key, this.model}) : super(key: key);

  @override
  _PharmaMyProfileState createState() => _PharmaMyProfileState();
}

class _PharmaMyProfileState extends State<PharmaMyProfile> {
  String loAd = "Loading..";
 // Body model;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  ProfileModel1 profileModel1;
  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
   // model = widget.model.model;
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
        ),
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
                                  leading: Icon(Icons.person),
                                  title: Text("NAME"),
                                  subtitle: Text(profileModel1.body.name??"N/A"),
                                ), ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: Icon(Icons.person),
                                  title: Text("REGISTRATION NO"),
                                  subtitle: Text(profileModel1.body.useraccount??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.phone),
                                  title: Text(
                                    "PHONE",
                                  ),
                                  subtitle: Text(profileModel1.body.mobile??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.face),
                                  title: Text(
                                    "GENDER",
                                  ),
                                  subtitle: Text(profileModel1.body.gender??"N/A"),
                                ),

                                ListTile(
                                  leading: Icon(Icons.email),
                                  title: Text("EMAIL"),
                                  subtitle: Text(profileModel1.body.email??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.contact_phone),
                                  title: Text("AADHAAR NO"),
                                  subtitle: Text(profileModel1.body.aadhaar??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text(
                                    "COUNTRY",
                                  ),
                                  subtitle: Text(profileModel1.body.country??"N/A"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text(
                                    "STATE",
                                  ),
                                  subtitle: Text(profileModel1.body.state??"N/A"),
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
