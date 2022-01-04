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

class ChangePassword extends StatefulWidget {
  final MainModel model;
  final String userId;

  const ChangePassword({Key key, this.model, this.userId}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  LoginResponse1 loginResponse1;
  var selectedMinValue;
  TextEditingController oldwpwd = new TextEditingController();
  TextEditingController newpwd = new TextEditingController();
  TextEditingController cnfpwd = new TextEditingController();
  bool isPassShow = true;
  bool isPassShow1 = true;
  bool isPassShow2 = true;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
   // UserMedicineList.pharmacyModel = null;
    setState(() {
      loginResponse1 = widget.model.loginResponse1;
     // _getLocationName();
      //callAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
    /*leading: BackButton(
             color: Colors.white,
           ),*/
    title: Text(
      'Change Password',
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
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: fromFieldPass("Current Password"),
        ),
        /*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: oldwpwd,
            decoration: InputDecoration(
              hintText: 'Old Password',
            ),
          ),
        ),*/
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: fromFieldPass1("New Password"),
        ),
       /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: newpwd,
            decoration: InputDecoration(
              hintText: 'New Password',
            ),
          ),
        ),*/
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: fromFieldPass2("Confirm Password"),
        ),
        /*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: cnfpwd,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
        ),*/
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
          padding: const EdgeInsets.symmetric(horizontal: 14),
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
  Widget fromFieldPass(
      String hint,) {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: textEditingController[0],
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
          /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
          //hintText: "Enter password",
          //contentPadding: EdgeInsets.only(top: ),
          /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: hint,
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow = !isPassShow;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        /*onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },*/
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }
  Widget fromFieldPass1(
      String hint,) {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: textEditingController[1],
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
          /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
          //hintText: "Enter password",
          //contentPadding: EdgeInsets.only(top: ),
          /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: hint,
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow1 ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow1 = !isPassShow1;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow1,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        /*onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },*/
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }
  Widget fromFieldPass2(
      String hint,) {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: textEditingController[2],
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
          /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
          //hintText: "Enter password",
          //contentPadding: EdgeInsets.only(top: ),
          /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: hint,
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow2? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow2 = !isPassShow2;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow2,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        /*onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },*/
        onSaved: (newValue) {
          print("onsave");
        },
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
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
          if(textEditingController[0].text == "" || textEditingController[0].text == null) {
            AppData.showInSnackBar(context, "Please enter  Current password");
          }else if (textEditingController[1].text == "" || textEditingController[1].text == null) {
            AppData.showInSnackBar(context, "Please enter  New password");
          }else if (textEditingController[2].text == "" || textEditingController[2].text == null) {
            AppData.showInSnackBar(context, "Please enter confirm password");
          }else if (textEditingController[2].text != textEditingController[1].text) {
            AppData.showInSnackBar(context, "New password doesn't match with confirm password");
          } else {
            var sendData ={
              "key" :loginResponse1.body.userMobile ,// "mobileno from login response",
              "name" :textEditingController[0].text,//"oldpassword",
              "code" :textEditingController[1].text ,// "newpassword",
              "pass" :loginResponse1.body.userPassword// "password from login response"
            } /*{"key":loginResponse1.body.userMobile, "code": cnfpwd.text}*/;
             MyWidgets.showLoading(context);
            log("API NAME>>>>" + ApiFactory.CHANGE_PASSWORD_USER);
            log("TO POST>>>>" + jsonEncode(sendData));
            widget.model.POSTMETHOD_TOKEN(
              api: ApiFactory.CHANGE_PASSWORD_USER,
              json: sendData,
              token: widget.model.token,
              fun: (Map<String, dynamic> map) {
                String body=map[Const.BODY];
                //Navigator.pop(context);
                setState(() {
                  if (map[Const.CODE] == Const.SUCCESS) {
                    popup( map[Const.MESSAGE], context);
                    loginResponse1.body.userPassword=body;
                    //Navigator.pop(context);
                    //callAPI();
                    //AppData.showInSnackDone(context, map[Const.MESSAGE]);
                  } else {
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  }
                });
              },
              /*fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    callAPI();
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);

                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  }*/
            );
            /*widget.model.POSTMETHOD(
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
            );*/
          }
        });
  }
}
