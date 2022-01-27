import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import '../../../main.dart';
import '../../../providers/app_data.dart';

// import 'package:add_2_calendar/add_2_calendar.dart';

class MedReminder extends StatefulWidget {
  final MainModel model;

  MedReminder({Key key, this.model}) : super(key: key);

  @override
  _MedReminderState createState() => _MedReminderState();
}

class _MedReminderState extends State<MedReminder> {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  int _selectedDestination = -1;
  bool isDataNotAvail = false;
 
  LoginResponse1 loginResponse1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
  
  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
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
  }
  // callApi() {
  //   widget.model.GETMETHODCALL_TOKEN(
  //       api: ApiFactory.USER_DASHBOARD + loginResponse1.body.user,
  //       token: widget.model.token,
  //       fun: (Map<String, dynamic> map) {
  //         String msg = map[Const.MESSAGE];
  //         if (map[Const.CODE] == Const.SUCCESS) {
  //           userDashboardModel = UserDashboardModel.fromJson(map);
  //           if (!userDashboardModel.body.isEContactAdded ||
  //               !userDashboardModel.body.isEContactAdded) {
  //             WidgetsBinding.instance.addPostFrameCallback((_) async {
  //               if (!mounted) dashOption1(context);
  //             });
  //           }
  //         } else {
  //           isDataNotAvail = true;
  //           //AppData.showInSnackBar(context, msg);
  //         }
  //       });
  // }
 
 Widget _button(String text, Function function) {
    return MyWidgets.nextButton(
      text: text,
      context: context,
      ///_loginId,passController
      fun: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("Notification"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Do you have taken medicine?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
       SizedBox(height: 20,),
          Row(children: [
            Expanded(
              child: _button(
                'Yes',
                (){
                  
                }
              ),
            ),
            Expanded(
              child: _button(
                'No',
                (){
                  
                }
              ),
            ),
          ],)

        ],),
      )
      
    );
  }
}


