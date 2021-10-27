import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/ChemistsLocationwiseModel.dart';
import 'package:user/models/ForgetUseridModel.dart';
import 'package:user/models/GooglePlacesModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:user/models/LoginResponse1.dart' as session;

class UserList extends StatefulWidget {
  MainModel model;


  UserList({Key key, this.model}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var selectedMinValue;
  bool isDataNotAvail = false;
  final ScrollController _scrollController = ScrollController();

  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  ForgotUseridModel userResponse;

  Position position;
  String longi, lati, city, addr, healthpro, type, medicallserviceType
  ;

  String medicallserviceTypelow;

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    userResponse=widget.model.userResponse;
    //callAPI();
  }


  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("User List"),
        /* leading: Icon(
        Icons.menu,
      ),*/
        centerTitle: true,
        actions: <Widget>[
          /*Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )
        ),*/
          /*Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                  Icons.more_vert
              ),
            )
        ),*/
        ],
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(

                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //controller: _scrollController,
                itemBuilder: (context, i) {

                  // Results patient = googlePlaceModel.results[i];
                 // userResponse.body userreponse=userResponse.body[i];
                  /* print(
                      "VALUEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee>>" +
                          i.toString() +
                          ((patient.photos != null &&
                              patient.photos.isNotEmpty)
                              ? ApiFactory.GOOGLE_PIC(
                              ref: patient.photos[0].photoReference)
                              : patient.icon));*/
                  return Container(
                    child: InkWell(
                      onTap: () {

                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: 13.0, right: 13,),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 5,
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Container(
                                //height: tileSize,
                                // width: double.maxFinite,
                                decoration: (i % 2 == 0)
                                    ? BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color:
                                            AppData.kPrimaryRedColor,
                                            width: 5)))
                                    : BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: AppData.kPrimaryColor,
                                            width: 5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        /*((patient.photos !=
                                            null &&
                                            patient.photos
                                                .isNotEmpty))*/
                                        // ?
                                        Material(
                                          elevation: 5.0,
                                          shape: CircleBorder(),
                                          child: CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage: NetworkImage(
                                                ""),
                                          ),
                                        ),
                                        //:
                                      /*  SizedBox(
                                          height: 85,
                                          child: Image.network(
                                            "",
                                          ),
                                        ),
                                        Image.asset(
                                          "",
                                          height: 40,
                                        ),*/
                                        SizedBox(
                                          width: spaceTab,
                                        ),
                                        Text(
                                          "Ipsita",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Column(
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  );
                },
                itemCount:userResponse.body.length??0,
              )
              //: Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }
}
