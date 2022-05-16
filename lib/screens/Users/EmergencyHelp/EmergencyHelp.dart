import 'dart:convert';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shake/shake.dart';

// import 'package:shake/shake.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/GooglePlacesModel.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/EmergencyHelpModel.dart';
import 'package:user/widgets/MyWidget.dart';
import '../../../models/LoginResponse1.dart';
import '../../../providers/Const.dart';

import '../../../providers/api_factory.dart';
import '../../../providers/app_data.dart';

class EmergencyHelp extends StatefulWidget {
  MainModel model;

  EmergencyHelp({Key key, this.model}) : super(key: key);

  @override
  _EmergencyHelpState createState() => _EmergencyHelpState();
}

class _EmergencyHelpState extends State<EmergencyHelp> {
  GooglePlaceModel googlePlaceModel;
  GooglePlacesSearchModel googlePlacesSearch;

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
  Position position;
  String longitude;
  String latitude;
  String cityName;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isShown = true;
  int k = 0;
  bool enabled;
  static int count = 0;
  bool forOnceShake=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    //callAPI();
    // callAmbulance();

    _gpsService();
    callAPI();
    // _getLocationName();
    ShakeDetector detector = ShakeDetector.autoStart(
        onPhoneShake: () {
          widget.model.longi = latitude;
          widget.model.lati = longitude;
          widget.model.city = cityName;
          print('longi ___ lati + ' +
              widget.model.longi +
              '' +
              widget.model.lati);
          // widget.model.emgmobile = emergencyHelpModel.emergency[0].mobile;
          // widget.model.placeIdno = googlePlaceModel?.results[0]?.placeId;
          /*googlePlaceModel==null?widget.model.placeIdno = googlePlaceModel?.results[0]?.placeId
                                : widget.model.placeIdno1 = googlePlaceModel?.results[0]?.placeId;*/
          if ((latitude == null || latitude == "") ||
              (longitude == null || longitude == "") && !forOnceShake) {
            AppData.showInSnackBar(context, "Please Allow Location");
          } else {
            /*setState(() {
              forOnceShake=true;
            });*/

             /* count++;
              if(count==4){*/
                Navigator.pushNamed(context, "/countDown");
            /*  }*/

            //detector.

          }
        },
        shakeThresholdGravity: 2.1);
  }

  Future _gpsService() async {
    enabled = await Geolocator().isLocationServiceEnabled();
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else {
      //_getLocationName();
    }

    return true;
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get current location"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                    _getLocationName();
                    //_getLocationName();
                    // _gpsService();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  _getLocationName() async {
    print('INNNNNNNN >>>>>>>>>>>>>>>>>>:');
    MyWidgets.showLoading(context);
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;

    //debugPrint('location: ${position.latitude}');
    print('location>>>>>>>>>>>>>>>>>>: ${position.latitude}');
    //latitude =position.latitude.toString();
    //longitude = position.longitude.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((position.latitude != null || position.latitude != "") ||
        (position.longitude != null || position.longitude != "")) {
      Navigator.pop(context);
      await preferences.setString("Latitude", position.latitude.toString());
      await preferences.setString("Longitude", position.longitude.toString());
      latitude = preferences.getString("Latitude");
      longitude = preferences.getString("Longitude");
      print('======111======== ' +
          ApiFactory.googleMapUrl(lati: latitude, longi: longitude));
      return true;
    } else {
      print('======222222======== ' +
          ApiFactory.googleMapUrl(lati: latitude, longi: longitude));
    }

    callAmbulance();

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
  }

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

          // setState(() {
          String msg = map[Const.MESSAGE];
          if (map[Const.STATUS1] == Const.SUCCESS) {
            if (map["emergency"] == null || map["emergency"].isEmpty) {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/setupcontacts");
            } else {
              setState(() {
                emergencyHelpModel = EmergencyHelpModel.fromJson(map);
              });

              /* if((latitude == null || latitude == "") || (longitude == null || longitude == "")){
                AppSettings.openLocationSettings();

              }
              else{
                _getLocationName();
                //Navigator.pushNamed(context, "/countDown");
              }*/
              if (enabled) {
                _getLocationName();
                //_checkGps();
              }
            }
          } else {
            isDataNotAvail = true;
            // AppData.showInSnackBar(context, msg);
          }
          // });
        });
  }

  callAmbulance() {
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_QUERY_API(
            lati: latitude, longi: longitude, healthpro: "ambulance"),
        fun: (Map<String, dynamic> map) {
          setState(() {
            //String msg = map[Const.MESSAGE];
            //if (map["status"] == "ok") {
            googlePlaceModel = GooglePlaceModel.fromJson(map);
            //Navigator.pop(context);
            if (googlePlaceModel != null &&
                googlePlaceModel.results.isNotEmpty) {
              getMobNo(googlePlaceModel.results[k].placeId);
            } else {
              AppData.showInSnackBar(context, "Data not found");
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
                    EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 10),
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                              title: Text(
                                list[i].name,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                list[i].relation,
                                style: TextStyle(color: Colors.black),
                              ),
                              /* trailing: InkWell(
                                onTap: () {
                                  AppData.launchURL("tel://" + list[i].mobile);
                                },
                                child: Icon(Icons.call, color: Color(0xFF2372B6)),
                              ),*/
                              onTap: () {
                                // call setstate
                                setState(() {
                                  // new line
                                  // change the bool variable based on the index
                                  // AppData.launchURL("tel://" + list[i].mobile);
                                });
                              }),
                          (i == list.length - 1)
                              ? Container()
                              : Divider(height: 1, color: Colors.black54),
                        ],
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

  showUserList1(BuildContext context, List<Results> results) {
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              getMobNo(results[i].placeId);
                            },
                            title: Text(
                              results[i].name,
                              style: TextStyle(color: Colors.black),
                            ),
                            /*trailing: InkWell(
                      onTap: () {
                        AppData.launchURL("tel://" + results[i].name);

                        //  AppData.launchURL("tel://" + list[i].mobile);
                      },
                      child: Icon(Icons.call, color: Color(0xFF2372B6) ),
                      )*/
                          ),
                          (i == results.length - 1)
                              ? Container()
                              : Divider(height: 1, color: Colors.black54),
                        ],
                      );
                    },
                    itemCount: 5,
                  ),
                ),
              );
            },
          );
        });
  }

  getMobNo(placeId) {
    // MyWidgets.showLoading(context);
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_SEARCH(
            place_id: placeId /*"ChIJ9UsgSdYJGToRiGHjtrS-JNc"*/),
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          // Navigator.pop(context);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.RESULT_OK) {
              GooglePlacesSearchModel googlePlacesSearch =
                  GooglePlacesSearchModel.fromJson(map);
              if (googlePlacesSearch?.result?.formattedPhoneNumber != null) {
                /*AppData.launchURL("tel://" +
                    googlePlacesSearch.result
                        .formattedPhoneNumber);*/

                widget.model.hospitalNo =
                    googlePlacesSearch.result.formattedPhoneNumber;

                /*FlutterPhoneDirectCaller.callNumber(
                    googlePlacesSearch.result.formattedPhoneNumber);*/
              } else {
                if (googlePlaceModel.results.length > (k + 1)) {
                  getMobNo(googlePlaceModel.results[(k + 1)].placeId);
                } else {
                  AppData.showInSnackBar(
                      context, "Ambulance Mobile no is not available");
                }

                // AppData.showInSnackBar(context, "Ambulance Mobile no is not available");
              }
              //log(">>>>>>>GGGGG<<<<<<<" + jsonEncode(map));
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }

            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (emergencyHelpModel != null)
        ? /*((position.latitude == null || position.latitude == "") || (position.longitude == null || position.longitude == ""))?MyWidgets.showLoading(context):*/
        Stack(
            children: [
              Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MyLocalizations.of(context)
                                  .text("EMERGENCY_HELP"),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/setupcontacts")
                                      .then((value) => callAPI());
                                },
                                child: Icon(Icons.settings))),
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    automaticallyImplyLeading: false,
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
                            InkWell(
                              onTap: () {
                                widget.model.longi = latitude;
                                widget.model.lati = longitude;
                                widget.model.city = cityName;
                                print('longi ___ lati + ' +
                                    widget.model.longi +
                                    '' +
                                    widget.model.lati);
                                // widget.model.emgmobile = emergencyHelpModel.emergency[0].mobile;
                                // widget.model.placeIdno = googlePlaceModel?.results[0]?.placeId;
                                /*googlePlaceModel==null?widget.model.placeIdno = googlePlaceModel?.results[0]?.placeId
                                : widget.model.placeIdno1 = googlePlaceModel?.results[0]?.placeId;*/
                                if ((latitude == null || latitude == "") ||
                                    (longitude == null || longitude == "")) {
                                  AppData.showInSnackBar(
                                      context, "Please Allow Location");
                                } else {
                                  Navigator.pushNamed(context, "/countDown");
                                }

                                // callHelpBtn();
                              },
                              child: Container(
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
                                        child: Lottie.asset(
                                            'assets/intro/redZone.json'),
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
                                          MyLocalizations.of(context)
                                              .text("HELP"),
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
                            ),
                            /* RichText(
                        text: TextSpan(
                          text: 'Hello ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' world!'),
                          ],
                        ),
                      ),*/
                            /*AnimatedDefaultTextStyle(
                        child: Text("3"),
                        style: TextStyle(color: Colors.red), duration: Duration(seconds: 6),
                      ),*/
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
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //change here don't //worked
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                color: Color(0xFFCF3564),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    new Spacer(),
                                    InkWell(
                                        onTap: () {
                                          FlutterPhoneDirectCaller.callNumber(
                                              (emergencyHelpModel
                                                      ?.emergency[0]?.mobile ??
                                                  emergencyHelpModel
                                                      ?.emergency[1]?.mobile));
                                          // Navigator.pop(context);
                                          //  AppData.launchURL("tel:" + emergencyHelpModel.emergency[0].mobile);
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            MyLocalizations.of(context)
                                                .text("CALL_EMERGENCY1"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        )),
                                    new Spacer(),
                                    Container(
                                        child: Row(children: [
                                      /* InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                      AppData.launchURL("tel://" +
                                          emergencyHelpModel.emergency[0].mobile);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Color(0xFFCF3564),
                                      ),
                                    )),*/
                                      Container(
                                        width: 2,
                                        child: Divider(
                                          thickness: 21,
                                          color: Color(0xFFCF3564),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if (emergencyHelpModel != null &&
                                                emergencyHelpModel
                                                    .emergency.isNotEmpty)
                                              showUserList(context,
                                                  emergencyHelpModel.emergency);
                                            else
                                              AppData.showInSnackBar(
                                                  context, "Data not found");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Icon(
                                              Icons.info,
                                              color: Color(0xFFCF3564),
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
                                  //color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: Image.asset(
                                                    "assets/images/callambulance.png",
                                                    height: 30,
                                                  ))),
                                          Container(
                                            width: 2,
                                            child: Divider(
                                              thickness: 21,
                                              color: Color(0xFF2372B6),
                                            ),
                                          ),
                                          /* SizedBox(width: 100,),*/
                                        ])),
                                    new Spacer(),
                                    /*  Expanded(child:*/
                                    InkWell(
                                        onTap: () {
                                          // Navigator.pop(context);
                                          //FlutterPhoneDirectCaller.callNumber(googlePlacesSearch.result[0].placeId);
                                          //AppData.launchURL("tel://" + emergencyHelpModel.ambulance);

                                          if (googlePlaceModel == null) {
                                            MyWidgets.showLoading(context);
                                            widget.model.GETMETHODCAL(
                                                api:
                                                    ApiFactory.GOOGLE_QUERY_API(
                                                        lati: latitude,
                                                        longi: longitude,
                                                        healthpro: "ambulance"),
                                                fun:
                                                    (Map<String, dynamic> map) {
                                                  setState(() {
                                                    //String msg = map[Const.MESSAGE];
                                                    //if (map["status"] == "ok") {
                                                    googlePlaceModel =
                                                        GooglePlaceModel
                                                            .fromJson(map);
                                                    Navigator.pop(context);
                                                    if (googlePlaceModel !=
                                                            null &&
                                                        googlePlaceModel.results
                                                            .isNotEmpty) {
                                                      /* showUserList1(context,
                                                    googlePlaceModel
                                                        .results);*/
                                                      /*for (var i = 0; i < googlePlaceModel.results.length; i++) {*/
                                                      getMobNo(googlePlaceModel
                                                          .results[0].placeId);
                                                      /*}
                                                */
                                                    } else
                                                      AppData.showInSnackBar(
                                                          context,
                                                          "Data not found");
                                                    /* } else {
                                                    isDataNotAvail = true;
                                                       AppData.showInSnackBar(context, "Google api doesn't work");
                                            }*/
                                                  });
                                                });
                                          } else {
                                            if (googlePlaceModel != null &&
                                                googlePlaceModel
                                                    .results.isNotEmpty) {
                                              getMobNo(googlePlaceModel
                                                  .results[0].placeId);
                                            }
                                          }
                                        },
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .text("CALL_AMBULANCE"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                        )),
                                    /* ),*/
                                    new Spacer(),
                                    Row(
                                        //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          /* InkWell(
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
                                            color:Color(0xFF2372B6),
                                          ),
                                        )),*/
                                          Container(
                                            width: 2,
                                            child: Divider(
                                              thickness: 21,
                                              color: Color(0xFF2372B6),
                                            ),
                                          ),
                                          /* SizedBox(width: 100,),*/
                                          InkWell(
                                              onTap: () {
                                                if (googlePlaceModel == null) {
                                                  MyWidgets.showLoading(
                                                      context);
                                                  widget.model.GETMETHODCAL(
                                                      api: ApiFactory
                                                          .GOOGLE_QUERY_API(
                                                              lati: latitude,
                                                              longi: longitude,
                                                              healthpro:
                                                                  "Ambulance"),
                                                      fun: (Map<String, dynamic>
                                                          map) {
                                                        setState(() {
                                                          //String msg = map[Const.MESSAGE];
                                                          //if (map["status"] == "ok") {
                                                          googlePlaceModel =
                                                              GooglePlaceModel
                                                                  .fromJson(
                                                                      map);
                                                          Navigator.pop(
                                                              context);
                                                          if (googlePlaceModel !=
                                                                  null &&
                                                              googlePlaceModel
                                                                  .results
                                                                  .isNotEmpty)
                                                            showUserList1(
                                                                context,
                                                                googlePlaceModel
                                                                    .results);
                                                          else
                                                            AppData.showInSnackBar(
                                                                context,
                                                                "Data not found");
                                                          /* } else {
                  isDataNotAvail = true;
                  AppData.showInSnackBar(context, "Google api doesn't work");
                }*/
                                                        });
                                                      });
                                                } else {
                                                  if (googlePlaceModel !=
                                                          null &&
                                                      googlePlaceModel
                                                          .results.isNotEmpty)
                                                    showUserList1(
                                                        context,
                                                        googlePlaceModel
                                                            .results);
                                                }
                                              },
                                              // Navigator.pop(context);

                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Icon(
                                                  Icons.info,
                                                  color: Color(0xFF2372B6),
                                                ),
                                              )),
                                        ]) /*),*/
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                            //       Padding(
                            //         padding: const EdgeInsets.only(
                            //           left: 15.0,
                            //           right: 15.0,
                            //         ),
                            //         child: Container(
                            //           width: MediaQuery.of(context).size.width,
                            //           height: 50,
                            //           decoration: BoxDecoration(
                            //             // color: Colors.indigo[50],
                            //             borderRadius: BorderRadius.circular(5.0),
                            //             border: Border.all(color: Colors.grey, width: 0.7),
                            //           ),
                            //           child: Row(
                            //             //mainAxisAlignment: MainAxisAlignment.spic,
                            //             children: [
                            //               Container(
                            //                   child: Row(
                            //                       //mainAxisAlignment: MainAxisAlignment.spic,
                            //                       children: [
                            //                     InkWell(
                            //                         onTap: () {
                            //                           // Navigator.pop(context);
                            //                         },
                            //                         child: Padding(
                            //                             padding: const EdgeInsets.only(
                            //                                 left: 10.0, right: 10.0),
                            //                             child: Image.asset(
                            //                               "assets/images/Call_police.png",
                            //                               height: 30,
                            //                             ))),
                            //                     Container(
                            //                       width: 2,
                            //                       child: Divider(
                            //                         thickness: 21,
                            //                         color: Color(0xFFCF3564),
                            //                       ),
                            //                     ),
                            //                     /* SizedBox(width: 100,),*/
                            //                   ])),
                            //               new Spacer(),
                            //               /*  Expanded(child:*/
                            //               InkWell(
                            //                   onTap: () {
                            //                     //Navigator.pop(context);
                            //                    // AppData.launchURL("tel://" + emergencyHelpModel.police);
                            //                     //FlutterPhoneDirectCaller.callNumber("7008553233");
                            //
                            //                     if(googlePlaceModel==null) {
                            //                       MyWidgets.showLoading(context);
                            //                       widget.model.GETMETHODCAL(
                            //                           api: ApiFactory
                            //                               .GOOGLE_QUERY_API(
                            //                               lati: latitude,
                            //                               longi: longitude,
                            //                               healthpro: "Ambulance"),
                            //                           fun: (
                            //                               Map<String, dynamic> map) {
                            //                             setState(() {
                            //                               //String msg = map[Const.MESSAGE];
                            //                               //if (map["status"] == "ok") {
                            //                               googlePlaceModel =
                            //                                   GooglePlaceModel
                            //                                       .fromJson(
                            //                                       map);
                            //                               Navigator.pop(context);
                            //                               if (googlePlaceModel !=
                            //                                   null &&
                            //                                   googlePlaceModel
                            //                                       .results.isNotEmpty) {
                            //                                 /* showUserList1(context,
                            //                                     googlePlaceModel
                            //                                         .results);*/
                            //                                 getMobNo(googlePlaceModel.results[0].placeId);
                            //
                            //                               }
                            //                               else
                            //                                 AppData.showInSnackBar(
                            //                                     context,
                            //                                     "Data not found");
                            //                               /* } else {
                            //   isDataNotAvail = true;
                            //   AppData.showInSnackBar(context, "Google api doesn't work");
                            // }*/
                            //                             });
                            //                           });
                            //                     }else{
                            //                       if (googlePlaceModel !=
                            //                           null &&
                            //                           googlePlaceModel
                            //                               .results.isNotEmpty) {
                            //                         getMobNo(googlePlaceModel.results[0].placeId);
                            //                       }
                            //                     }
                            //
                            //                   },
                            //                   child: Text(
                            //                     MyLocalizations.of(context).text("CALL_POLICE"),
                            //                     style: TextStyle(
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 15,
                            //                         color: Colors.black),
                            //                   )),
                            //               /* ),*/
                            //               new Spacer(),
                            //               Row(
                            //                   //mainAxisAlignment: MainAxisAlignment.spic,
                            //                   children: [
                            //                    /* InkWell(
                            //                         onTap: () {
                            //                           //Navigator.pop(context);
                            //                           AppData.launchURL("tel://" + emergencyHelpModel.police);
                            //                         },
                            //                         child: Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(right: 10.0),
                            //                           child: Icon(
                            //                             Icons.phone_in_talk,
                            //                             color: Color(0xFFCF3564),
                            //                           ),
                            //                         )),*/
                            //                     Container(
                            //                       width: 2,
                            //                       child: Divider(
                            //                         thickness: 21,
                            //                         color: Color(0xFFCF3564),
                            //                       ),
                            //                     ),
                            //                     /* SizedBox(width: 100,),*/
                            //                     InkWell(
                            //                         onTap: () {
                            //                           MyWidgets.showLoading(context);
                            //                           widget.model.GETMETHODCAL(
                            //                               api: ApiFactory.GOOGLE_QUERY_API(
                            //                                   lati: latitude,
                            //                                   longi: longitude,
                            //                                   healthpro: "Police"),
                            //                               fun: (Map<String, dynamic> map) {
                            //                                 setState(() {
                            //                                   //String msg = map[Const.MESSAGE];
                            //                                   //if (map["status"] == "ok") {
                            //                                   googlePlaceModel =
                            //                                       GooglePlaceModel.fromJson(
                            //                                           map);
                            //
                            //                                   Navigator.pop(context);
                            //                                   if (googlePlaceModel != null &&
                            //                                       googlePlaceModel
                            //                                           .results.isNotEmpty)
                            //                                     showUserList1(context,
                            //                                         googlePlaceModel.results);
                            //                                   else
                            //                                     AppData.showInSnackBar(
                            //                                         context, "Data not found");
                            //                                   /* } else {
                            //   isDataNotAvail = true;
                            //   AppData.showInSnackBar(context, "Google api doesn't work");
                            // }*/
                            //                                 });
                            //                               });
                            //                         },
                            //                         child: Padding(
                            //                           padding: const EdgeInsets.only(
                            //                               left: 10.0, right: 10.0),
                            //                           child: Icon(
                            //                             Icons.info,
                            //                             color: Color(0xFFCF3564),
                            //                           ),
                            //                         )),
                            //                   ]) /*),*/
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              (isShown)
                  ? Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.black54,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isShown = false;
                          });
                        },
                      ),
                    )
                  : Container(),
              Positioned(
                  right: 22,
                  top: 25,
                  child: Visibility(
                    visible: isShown,
                    child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isShown = false;
                          });
                        },
                        enableFeedback: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Visibility(
                            visible: isShown,
                            child: SafeArea(
                                child: Image.asset(
                                    "assets/images/indication.png")))),
                  ))
            ],
          )
        : Scaffold(
            appBar: AppBar(
              title: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MyLocalizations.of(context).text("EMERGENCY_HELP"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/setupcontacts")
                                .then((value) => callAPI());
                          },
                          child: Icon(Icons.settings))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
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
