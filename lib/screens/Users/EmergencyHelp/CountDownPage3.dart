import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:user/widgets/Buttons.dart';
import 'package:user/widgets/MyWidget.dart';

class CountDownPage3 extends StatefulWidget {
  final MainModel model;

  const CountDownPage3({Key key, this.model}) : super(key: key);

  @override
  _CountDownPage3State createState() => _CountDownPage3State();
}

class _CountDownPage3State extends State<CountDownPage3> {
  static const int kStartValue = 4;
  bool isComplete = false;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  int timerCount = 3;

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 9);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount == 0) {
          // setState(() {
            timer.cancel();
          // });
        } else {
          // setState(() {
            _controllerStream.add(timerCount--);
          // });
        }
      },
    );
  }

  StreamController<int> _controllerStream=StreamController<int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _getLocationName();
    startTimer();
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
  }

  countDownTimer() async {
    for (int x = timerCount; x > 0; x--) {
      await Future.delayed(Duration(seconds: 3)).then((_) {
        if (mounted)
          setState(() {
            timerCount = timerCount - 1;
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
            cityName = finder?.addressComponents[4]?.longName ?? "";
            // print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Buttons.downloadButton(
          title: "Cancel",
          context: context,
          function: () {
            Navigator.pop(context);
          }),
      body: new Container(
        child: new Center(
            child: StreamBuilder<int>(
              stream: _controllerStream.stream,
              builder: (context,AsyncSnapshot<int> data){
                if(data.hasData)
                return Text(
                  (data == 0) ? "SENT" : data.toString(),
                  style: new TextStyle(
                      fontSize: (data == 0) ? 100 : 150.0,
                      color: AppData.kPrimaryRedColor,
                      fontWeight: FontWeight.w500),
                );
                else
                  return Text("Error is: "+data.error.toString());
              }
            )),
      ),
    );
  }
}
