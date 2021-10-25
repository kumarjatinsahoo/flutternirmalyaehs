import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/ForgotPinView.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class ConfirmPassword extends StatefulWidget {
  final MainModel model;
  final String userId;

  const ConfirmPassword({Key key, this.model, this.userId}) : super(key: key);

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  var selectedMinValue;
  TextEditingController newpwd = new TextEditingController();
  TextEditingController cnfpwd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
    /*leading: BackButton(
             color: Colors.white,
           ),*/
    title: Text(
      'Forgot Password',
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: AppData.kPrimaryColor,
    iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: newpwd,
            decoration: InputDecoration(
              hintText: 'New Password',
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: cnfpwd,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
        ),
        /*  SizedBox(height: size.height * 0.01,),
            Text('or', style: TextStyle(fontSize: 17, ),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _mobileno,
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  //UpperCaseTextFormatter(),
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  hintText: 'Mobile Number',


                ),
              ),
            ),
*/
        SizedBox(
          height: size.height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _submitButton(),
        ),
        SizedBox(
          height: size.height * 0.09,
        ),
        /*  InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/forgotuserid");
              },
              child: Text('Forgot User id?'.toUpperCase(), style: TextStyle(
                fontSize: 15,

              ),),
            ),*/
      ],
    ),
      ),
    );
  }

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
             /* Navigator.pop(context, true);
              Navigator.pop(context, true);
              Navigator.pop(context, true);*/
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
        text: "submit".toUpperCase(),
        context: context,
        fun: () {
          if (newpwd.text == "" || cnfpwd.text == null) {
            AppData.showInSnackBar(context, "Please enter  new password");
          }else if (cnfpwd.text == "" || cnfpwd.text == null) {
            AppData.showInSnackBar(context, "Please enter confirm password");
          }else if (cnfpwd.text != newpwd.text) {
            AppData.showInSnackBar(context, "New password doesn't match with confirm password");
          } else {
            var sendData = {"key": widget.userId, "code": cnfpwd.text};
             MyWidgets.showLoading(context);
            widget.model.POSTMETHOD(
              api: ApiFactory.CHNG_PASS,
              json: sendData,
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  popup("Password Changed Successfully",context);
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              },
            );
          }
        });
  }
}
