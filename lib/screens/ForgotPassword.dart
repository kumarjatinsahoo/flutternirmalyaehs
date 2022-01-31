import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/ForgotPinView.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  final MainModel model;

  const ForgotPassword({Key key, this.model}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var selectedMinValue;
  TextEditingController _mobileno = new TextEditingController();
  TextEditingController _userid = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        /*leading: BackButton(
             color: Colors.white,
           ),*/
        title: Text(
          MyLocalizations.of(context).text("FORGOT_PASSWORD"),
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
                controller: _userid,
                decoration: InputDecoration(
                  hintText:MyLocalizations.of(context).text("UHID_NO"),
                ),
              ),
            ),
            /* SizedBox(height: size.height * 0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                 decoration: InputDecoration(
                   hintText: 'Email ID',
                 ),
             ),
              ),*/
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(MyLocalizations.of(context).text("OR"),
              style: TextStyle(
                fontSize: 17,
              ),
            ),
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
                  counterText: "",
                  hintText:MyLocalizations.of(context).text("MOBILE_NO"),
                ),
              ),
            ),
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/forgotuserid");
              },
              child: Text(
                MyLocalizations.of(context).text("FORGOT_USERID").toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("SUBMIT").toUpperCase(),
      context: context,
      fun: () {
        if (_mobileno.text == "" && _userid.text == "") {
          AppData.showInSnackBar(context, "Please enter UHID no or mobile no");
        } else {
          var sendData;
          if (_userid.text != "") {
            sendData = {"key": _userid.text, "name": "UHID no"};
          } else {
            sendData = {"key": _mobileno.text, "name": "Mobile number"};
          }
          widget.model.phnNo = _mobileno.text;
          MyWidgets.showLoading(context);
          widget.model.POSTMETHOD(
              api: ApiFactory.FORGOT_OTP,
              json: sendData,
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  setState(() {
                    String userid = map["body"]["key"];
                    String otp = map["body"]["code"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ForgotPinView(
                          model: widget.model,
                          userId: userid,
                          otp: otp,
                        ),
                      ),
                    );
                  });
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              });
          // widget.model.phnNo = _loginId.text;
          //Navigator.pushNamed(context, "/otpView");
          // Navigator.pushNamed(context, "/pinView");
        }
      },
    );
  }
}
