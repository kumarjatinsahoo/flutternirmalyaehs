import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/GetUserIDModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class CreateUserIDScreen extends StatefulWidget {
  final MainModel model;

  const CreateUserIDScreen({Key key, this.model}) : super(key: key);

  @override
  _CreateUserIDScreenState createState() => _CreateUserIDScreenState();
}

class _CreateUserIDScreenState extends State<CreateUserIDScreen> {
  var selectedMinValue;
  TextEditingController _uhid= new TextEditingController();
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
          'Create User ID',
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
                controller: _uhid,
                inputFormatters: [
                  //UpperCaseTextFormatter(),
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
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
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _userid,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  //UpperCaseTextFormatter(),
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  counterText: "",
                  hintText:'Create User ID',
                ),
              ),
            ),
            //  SizedBox(
            //   height: size.height * 0.01,
            // ),
           
            // Visibility(
            //   visible: isOTP,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 30),
            //     child: TextFormField(
            //       controller: _otpText,
            //       maxLength: 10,
            //       keyboardType: TextInputType.number,
            //       // inputFormatters: [
            //       //   //UpperCaseTextFormatter(),
            //       //   // ignore: deprecated_member_use
            //       //   WhitelistingTextInputFormatter(RegExp("[0-9]")),
            //       // ],
            //       decoration: InputDecoration(
            //         counterText: "",
            //         hintText:'Submit OTP',
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _otpButton(),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
           
          ],
        ),
      ),
    );
  }

  Widget _otpButton() {
    return MyWidgets.nextButton(
      text: 'Send OTP',
      context: context,
      fun: () {        
        if (_uhid.text == null || _uhid.text == "") {
          AppData.showInSnackBar(context, "Please enter UHID no");
        } 
        else if (_userid.text == "" || _userid.text == null) {
          AppData.showInSnackBar(context, "Please enter userid");
        }  
       
        else{
          //  MyWidgets.showLoading(context);
       widget.model.GETMETHODCALL(
          api: ApiFactory.GET_OTP_USERID(
            _uhid.text.toString(),
            _userid.text.toString()
            ),
          fun: (Map<String, dynamic> map) async{
            // print('_uhid.text ' + _uhid.text + ' ' +_userid.text );
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {              
                GetUserIDModel loginResponse = GetUserIDModel.fromJson(map);
                  print('OTP------------------------' + loginResponse.body.otp.toString());
                // widget.loginData=loginResponse;
                widget.model.otpText = loginResponse.body.otp.toString();
                widget.model.userid=_userid.text;
                widget.model.uhid=_uhid.text;
                Navigator.pushNamed(context, "/pinViewUserID");

              });

            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        }         
        }      
    );
  }

 
}
