import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/EmergencyHelpModel.dart';
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
      (animation.value.toString() == "0") ? "" : animation.value.toString(),
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
  EmergencyHelpModel emergencyHelpModel;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> userMobList=[];

  session.LoginResponse1 loginResponse1;
  @override
  void initState() {
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    callEmergency();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );
   print('+++++++++++++++= '+ ApiFactory.googleMapUrl(lati:widget.model.longi ,longi: widget.model.lati));
    _controller.forward(from: 0.0).whenComplete(() {
       callHelpBtn();
      // _sendSMS("Hi this is "+loginResponse1.body.userName+", eHealthSystem Emergency Alert! I need help. My Location is "+ApiFactory.googleMapUrl(lati:widget.model.longi ,longi: widget.model.lati), userMobList);
      //callAPI();
     
    }
    );
  }

  callHelpBtn() {    
    Map<String, dynamic> postmap = {
      "userid" : loginResponse1.body.user,
      "mapurl" : ApiFactory.googleMapUrl(longi: widget.model.longi,lati:widget.model.lati)
    };     
      widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.EMERGENCY_HELP_NEW,   
        token: widget.model.token,
        json: postmap,
        fun: (Map<String, dynamic> map) {
          print("Narmada is>>>>" +  ApiFactory.googleMapUrl(longi: widget.model.longi,lati:widget.model.lati) + ' s ' + widget.model.longi);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.SUCCESS) {
              emergencyHelpModel = EmergencyHelpModel.fromJson(map);
             popup(map[Const.MESSAGE],context);
              // AppData.showInSnackDone(context, msg);
            
            } else {
              popuplailed(map[Const.MESSAGE],context);
              // isDataNotAvail = true;
              // AppData.showInSnackBar(context, msg);
            }
          });
        });
   
  }
   popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "",
        desc: msg,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
               Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
  popuplailed(String msg, BuildContext context) {
    return Alert(
        context: context,
        //title: "Success",
        title: "",
        //type: AlertType.info,
        onWillPopActive: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info,
              size: 140,
              color: Colors.red,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              msg,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            /*Text(
              "Mobile No. :"+mobile,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),*/

          ],
        ),
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }


  // callAPI() {
  //   MyWidgets.showLoading(context);
  //   widget.model.GETMETHODCALL_TOKEN(
  //       api: ApiFactory.SMS_TO_EMERGENCY +
  //           widget.model.user +
  //           "&longi=" +
  //           widget.model.longi +
  //           "&lati=" +
  //           widget.model.lati+"&mapurl=",
  //       token: widget.model.token,
  //       fun: (Map<String, dynamic> map) {
  //          Navigator.pop(context);
  //         // Navigator.pop(context);
  //         String msg = map[Const.MESSAGE];
  //         if (map["status"] == "success") {
  //           setState(() {
  //             AppData.showInSnackDone(context, msg);
  //           });
  //         } else {
  //           // isDataNotAvail = true;
  //           AppData.showInSnackBar(context, msg);
  //         }
  //       });
  // }

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

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  callEmergency() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.EMERGENCY_HELP + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.SUCCESS) {
              userMobList=[];
              emergencyHelpModel = EmergencyHelpModel.fromJson(map);
              emergencyHelpModel.emergency.forEach((element) {
                userMobList.add(element.mobile);
                print('========Narmada+++++++ ' + userMobList.toString());
              });
            } else {
              //isDataNotAvail = true;
              // AppData.showInSnackBar(context, msg);
            }
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
