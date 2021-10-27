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

class Countdown extends AnimatedWidget {
  MainModel model;

  Countdown({Key key, this.animation, this.model})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return new Text(
      (animation.value.toString() == "0") ? "SENT" : animation.value.toString(),
      style: new TextStyle(
          fontSize: (animation.value.toString() == "0") ? 100 : 150.0,
          color: AppData.kPrimaryRedColor,
          fontWeight: FontWeight.w500),
    );
  }
}

class CountDownPage extends StatefulWidget {
  MainModel model;

  CountDownPage({Key key, this.model});

  State createState() => new _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  static const int kStartValue = 4;
  bool isComplete = false;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );
    _controller.forward(from: 0.0).whenComplete(() {
      callAPI();
    });
  }


  callAPI() {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.SMS_TO_EMERGENCY +
            widget.model.user +
            "&longi=" +
            widget.model.longi +
            "&lati=" +
            widget.model.lati+"&mapurl=",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
           Navigator.pop(context);
          // Navigator.pop(context);
          String msg = map[Const.MESSAGE];
          if (map["status"] == "success") {
            setState(() {
              AppData.showInSnackDone(context, msg);
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
  }

  callApi(lat, longi) {
    print(">>>>>>>>>" + ApiFactory.GOOGLE_LOC(lat: lat, long: longi));
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          ResultsServer finder = ResultsServer.fromJson(map["results"][0]);
          print("finder>>>>>>>>>" + finder.toJson().toString());
          setState(() {
            address = "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
          });
        });
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
          child: new Countdown(
            //key: _scaffoldKey1,
            animation: new StepTween(
              begin: kStartValue,
              end: 0,
            ).animate(_controller),
          ),
        ),
      ),
    );
  }
}
