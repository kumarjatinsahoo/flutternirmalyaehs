import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:lottie/lottie.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/models/EmergencyHelpModel.dart';
import '../models/LoginResponse1.dart';
import '../providers/Const.dart';

import '../providers/api_factory.dart';
import '../providers/app_data.dart';

class EmergencyHelp extends StatefulWidget {
  MainModel model;

  EmergencyHelp({Key key, this.model}) : super(key: key);

  @override
  _EmergencyHelpState createState() => _EmergencyHelpState();
}

class _EmergencyHelpState extends State<EmergencyHelp> {
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

  LoginResponse1 loginResponse1;
  EmergencyHelpModel emergencyHelpModel;
  bool isDataNotAvail = false;
  //Position position;
  String longitude;
  String latitude;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
    _getLocationName();
  }
  _getLocationName() async {
    Position position = await Geolocator
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    debugPrint('location_latitude: ${position.latitude}');
    print('location_latitude>>>>>>>>>>>>>>>>>>: ${position.latitude}');
    debugPrint('location_longitude: ${position.longitude}');
    print('location_longitude>>>>>>>>>>>>>>>>>>: ${position.longitude}');
    longitude = position.longitude.toString();
    latitude = position.latitude.toString();
  }
  /*_getLocationName() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print('location>>>>>>>>>>>>>>>>>>: ${position.latitude}');
    try {
      final coordinates =
      new Coordinates(position.latitude, position.longitude);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      setState(() {
        cityName = "${first.addressLine}";
      });
    } catch (e) {
      print(e.toString());
    }
  }*/
  callAPI() {
    print(ApiFactory.EMERGENCY_HELP +
        loginResponse1.body.user +
        "\n" +
        loginResponse1.body.token);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.EMERGENCY_HELP + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));

          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.SUCCESS) {
              emergencyHelpModel = EmergencyHelpModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  showUserList(BuildContext context, List<Emergency> list) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding:
                    EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(list[i].name,style: TextStyle(color: Colors.black),),
                        subtitle: Text(list[i].relation,style: TextStyle(color: Colors.black),),
                        trailing: Icon(Icons.call,color: Colors.black),
                      );
                    },
                    itemCount: list.length,
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        //extendBody: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        appBar: AppBar(
          /*leading: BackButton(
                color: Colors.white,
              ),*/
          title: Text(
            'Emergency Help',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  /*Container(
                    width: double.infinity,
                    height: 150.0,
                    child: Center(
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(150.0),
                                child: Image.asset("assets/helplogo.png",
                                    height: 150)),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  Container(
                    width: size.width,
                    height: size.width,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: size.width,
                            width: size.width,
                            decoration: BoxDecoration(),
                            child: Lottie.asset('assets/intro/redZone.json'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: size.width - 230,
                            width: size.width - 230,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "HELP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MonteMed"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //change here don't //worked
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Image.asset(
                                        "assets/images/medical_emergency.png",
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    child: Divider(
                                      thickness: 21,
                                      color: Colors.red,
                                    ),
                                  ),
                                ]),
                          ),
                          new Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Call Emergency ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                          new Spacer(),
                          Container(
                              child: Row(children: [
                            InkWell(
                                onTap: () {
                                  // Navigator.pop(context);
                                  AppData.launchURL("tel://" +
                                      emergencyHelpModel.emergency[0].mobile);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.phone_in_talk,
                                    color: Colors.red,
                                  ),
                                )),
                            Container(
                              width: 2,
                              child: Divider(
                                thickness: 21,
                                color: Colors.red,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  if(emergencyHelpModel!=null && emergencyHelpModel.emergency.isNotEmpty)
                                  showUserList(
                                      context, emergencyHelpModel.emergency);
                                  else
                                    AppData.showInSnackBar(context, "Data not found");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.red,
                                  ),
                                )),
                          ]))
                        ],
                      ),
                    ),
                  ),
                  /*  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container( child:
                             Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                     InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },

                                    child:Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                     */
                  /* child: Image.asset(
                                        "assets/images/callambulance.png",
                                        fit: BoxFit.fitWidth,
                                        //width: ,
                                        height: 35.0,
                                      ),*/
                  /*
                                      child: Icon(
                                        Icons.group_rounded,
                                        color: Colors.red,
                                      ),
                                    )),

                     Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                */
                  /* SizedBox(width: 100,),*/ /*
                              ])*/ /*)*/ /*,
                          */
                  /*Expanded(*/ /*
            ),

                    Container(

                        child:
                        Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.red,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                */ /* SizedBox(width: 100,),*/
                  /*
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.red,
                                      ),
                                    )),
                              ]) */ /*),*/ /*
                    )
                        ],
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spic,
                        children: [
                          Container(
                              child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Image.asset(
                                          "assets/images/callambulance.png",
                                          height: 30,
                                        ))),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: AppData.kPrimaryColor,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                              ])),
                          new Spacer(),
                          /*  Expanded(child:*/
                          Text(
                            'Call Ambulance ',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          /* ),*/
                          new Spacer(),
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.spic,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);

                                      AppData.launchURL("tel://" +
                                          emergencyHelpModel.ambulance);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: AppData.kPrimaryColor,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    )),
                              ]) /*),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spic,
                        children: [
                          Container(
                              child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Image.asset(
                                          "assets/images/Call_police.png",
                                          height: 30,
                                        ))),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                              ])),
                          new Spacer(),
                          /*  Expanded(child:*/
                          Text(
                            'Call Police ',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          /* ),*/
                          new Spacer(),
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.spic,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                      AppData.launchURL(
                                          "tel://" + emergencyHelpModel.police);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.red,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.red,
                                      ),
                                    )),
                              ]) /*),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTile(
      {String name, String value, String value1, IconData icon, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Column(
        children: [
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              icon,
              size: 35.0,
              color: AppData.matruColor,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            name,
            style: TextStyle(fontFamily: "MonteMed"),
          ),
          (value != null)
              ? SizedBox(
                  height: 3,
                )
              : Container(),
          (value != null) ? Text(value) : Container(),
          (value1 != null)
              ? SizedBox(
                  height: 3,
                )
              : Container(),
          (value1 != null) ? Text(value1) : Container(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
