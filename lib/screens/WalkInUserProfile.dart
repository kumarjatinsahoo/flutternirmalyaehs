import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';

import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/PatientListModel.dart';

import '../providers/app_data.dart';

class WalkInUserProfile extends StatefulWidget {
  MainModel model;

  WalkInUserProfile({Key key, this.model}) : super(key: key);

  @override
  _WalkInUserProfileState createState() => _WalkInUserProfileState();
}

class _WalkInUserProfileState extends State<WalkInUserProfile> {
  String loAd = "Loading..";
  Body model;

  @override
  void initState() {
    super.initState();
    model = widget.model.model;
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
        body: (model != null)
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
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyLocalizations.of(context).text("USER_INFORMATION"),
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
                                        subtitle: Text(model.fName),
                                      ), ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.person),
                                        title: Text("REGISTRATION NO"),
                                        subtitle: Text(model.id??""),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text(
                                          "PHONE",
                                        ),
                                        subtitle: Text(model.mobile),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.face),
                                        title: Text(
                                          "GENDER",
                                        ),
                                        subtitle: Text(model.genderName),
                                      ),

                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text("EMAIL"),
                                        subtitle: Text(model.email??"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.contact_phone),
                                        title: Text("AADHAR NO"),
                                        subtitle: Text(model.aadhar??"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.info_outline),
                                        title: Text(
                                          "COUNTRY",
                                        ),
                                        subtitle: Text(model.countryName),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.info_outline),
                                        title: Text(
                                          "STATE",
                                        ),
                                        subtitle: Text(model.stateName),
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
              ));
  }

  String getHeaderString(int value) {
    switch (value) {
      case 1:
        return "1st Sonography";
      case 2:
        return "2nd Sonography";
      case 3:
        return "3rd Sonography";
      case 4:
        return "4th Sonography";
      default:
        return "Sonography";
    }
  }

  Widget getRow(String name, String value) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.black),
            ),
            Text(value),
          ],
        ),
      ],
    );
  }

  Widget getRow1(String name, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black),
              ),
              Text(value),
            ],
          ),
        ],
      ),
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
                  model.fName,
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
                  "AADHAR NO" +
                      ": " +
                      model.mobile,
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
                  backgroundImage: NetworkImage(model.profileImageName??AppData.defaultImgUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
