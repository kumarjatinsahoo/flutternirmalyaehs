import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
             appBar: AppBar(
               /*leading: BackButton(
                 color: Colors.white,
               ),*/
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor:AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),

           body: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 SizedBox(height: size.height * 0.02,),   
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                     decoration: InputDecoration(
                       hintText: 'User ID',                                                  
                     ),
                 ),
                  ),
               SizedBox(height: size.height * 0.01,),  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                     decoration: InputDecoration(
                       hintText: 'Email ID',                                                 
                     ),
                 ),
                  ),
                SizedBox(height: size.height * 0.01,),  
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
                
          SizedBox(height: size.height * 0.05,),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _submitButton(),
          ),
            SizedBox(height: size.height * 0.09,),
            InkWell(
             onTap: (){
               Navigator.pushNamed(context, "/forgotuserid");
             },
                         child: Text('Forgot User id?'.toUpperCase(), style: TextStyle(
                          fontSize: 15,
                         
                       ),),
            ),
         
         
                          
             ],),
           ),
                      
                      
          )  
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "submit".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/
      
        // Navigator.pushNamed(context, "/otpView");
        //}

        if (_mobileno.text == "" || _mobileno.text == null) {
    AppData.showInSnackBar(context, "Please enter Mobile No");
    } else if (_mobileno.text.length != 10) {
    AppData.showInSnackBar(context, "Please enter 10 digit Mobile No");
    } else {
    widget.model.phnNo = _mobileno.text;
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
    api: ApiFactory.LOGIN_Otp(_mobileno.text),
    fun: (Map<String, dynamic> map) {
    Navigator.pop(context);
    log("LOGIN RESPONSE>>>>" + jsonEncode(map));
    //AppData.showInSnackBar(context, map[Const.MESSAGE]);
    if (map[Const.CODE] == Const.SUCCESS) {
    setState(() {
    LoginResponse1 loginResponse = LoginResponse1.fromJson(map);
    // widget.model.loginData=loginResponse;
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (BuildContext context) => PinView(
    loginData: loginResponse,
    model: widget.model,
    )),
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