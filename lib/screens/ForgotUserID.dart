import 'package:flutter/services.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class ForgotUserID extends StatefulWidget {
  final MainModel model;

  const ForgotUserID({Key key, this.model}) : super(key: key);
  @override
  _ForgotUserIDState createState() => _ForgotUserIDState();
}

class _ForgotUserIDState extends State<ForgotUserID> {
  var selectedMinValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
            /*appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),*/
            appBar: AppBar(
              /*leading: BackButton(
                color: Colors.white,
              ),*/
              title: Text(
                'Forgot User ID',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
           body: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [    
                          SizedBox(height: size.height * 0.02,),                   
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                     decoration: InputDecoration(
                       hintText: 'Email ID',                                                 
                     ),
                      inputFormatters: [
                        //UpperCaseTextFormatter(),
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9.a-zA-Z0-9.&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")),
                      ],
                 ),
                  ),
                 SizedBox(height: size.height * 0.02,),
                 Text('or', style: TextStyle(fontSize: 17, ),),
                
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                     child: TextFormField(
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
                
          SizedBox(height: size.height * 0.07,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _submitButton(),
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
      },
    );
  }

  
}