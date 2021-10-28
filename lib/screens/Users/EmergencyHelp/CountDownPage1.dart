import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/Buttons.dart';
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/widgets/MyWidget.dart';

class CountDownPage1 extends StatefulWidget {
  MainModel model;

  CountDownPage1({Key key, this.model});

  State createState() => new _CountDownPage1State();
}

class _CountDownPage1State extends State<CountDownPage1> {

  static const int kStartValue = 4;
  bool isComplete = false;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  int timerCount=3;

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timerCount == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timerCount--;
          });
        }
      },
    );
  }


  @override
  void initState() {
    super.initState();
    //loginResponse1=widget.model.loginResponse1;
    /* longitudes = widget.model.longi;
    latitudes = widget.model.lati;
    cityName = widget.model.city;*/
    _getLocationName();
    //countDownTimer();
    startTimer();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: new Duration(seconds: kStartValue),
    // );
    // _controller.forward(from: 0.0).whenComplete(() {
    //   pushNotification();
    //   setState(() {
        // isComplete = true;
      // });

    // });
//callAPI();
    //_controller.
  }


  callAPI() {
   // MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.SMS_TO_EMERGENCY +
            widget.model.user +
            /* "&mapurl=" +"" +*/
            "&longi=" +
            longitudes +
            "&lati=" +
            latitudes,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          // Navigator.pop(context);
          // Navigator.pop(context);
          String msg = map[Const.MESSAGE];
          if (map["status"] == "success") {
            setState(() {
              AppData.showInSnackBar(context, msg);
            });
          } else {
            // isDataNotAvail = true;
            AppData.showInSnackBar(context, msg);
          }
        });
  }

  pushNotification() {
    var postData = {
      "to": "/topics/9121488220723700",
      "data": {"body": "Test Notification !!!", "title": "Test Title !!!"},
      "notification": {"body": "SOS Message", "title": "eHealthSystem"}
    };
    MyWidgets.showLoading(context);
    widget.model.PUSH_NOTIFICATION(
        json: postData,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map.containsKey("message_id")) {
            setState(() {
              AppData.showInSnackBar(context, "Successfully Sent");
            });
          } else {
            // isDataNotAvail = true;
            AppData.showInSnackBar(context, "Something went wrong");
          }
        });
  }



  _getLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print(
        'location>>>>>>>>>>>>>>>>>>: ${position.latitude},${position.longitude}');
    callApi(position.latitude.toString(), position.longitude.toString());
    /* try {
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      //var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      print("${first.locality}}");
      setState(() {
        address = "${first.addressLine}";
        cityName = first.locality;
        longitudes = position.longitude.toString();
        latitudes = position.altitude.toString();
      });
    } catch (e) {
      print(e.toString());
    }*/
  }
  countDownTimer() async {
    //int timerCount;
    for (int x = timerCount; x > 0; x--) {
      await Future.delayed(Duration(seconds: 3)).then((_) {
        if(mounted)
        setState(() {
          timerCount = timerCount- 1;
        });
      });
    }
  }


  callApi(lat, longi) {
    print(">>>>>>>>>" + ApiFactory.GOOGLE_LOC(lat: lat, long: longi));
    //MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          ResultsServer finder = ResultsServer.fromJson(map["results"][0]);
          print("finder>>>>>>>>>" + finder.toJson().toString());
          setState(() {
            address = "${finder.formattedAddress}";
            cityName = finder?.addressComponents[4]?.longName??"";
            // print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
          });
        });
  }

  sentToServer() {
    // widget.model.POSTMETHOD(api: api, json: json, fun: fun)
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.play_arrow),
        onPressed: () => _controller.forward(from: 0.0),
      ),*/
      key: _scaffoldKey1,
      bottomNavigationBar: Buttons.downloadButton(
          title: "Cancel",
          context: context,
          function: () {
            Navigator.pop(context);
          }),
      body: new Container(
        child: new Center(
          child: Text(
            (timerCount == 0) ? "SENT" : timerCount.toString(),
            style: new TextStyle(
                fontSize: (timerCount==0) ? 100 : 150.0,
                color: AppData.kPrimaryRedColor,
                fontWeight: FontWeight.w500),
          )
        ),
      ),
    );
  }
}
