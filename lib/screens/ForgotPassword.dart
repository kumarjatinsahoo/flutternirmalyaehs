import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
             appBar: AppBar(
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.black),
        ),

           body: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.only( left:5.0,right: 5.0,top: 5.0),
                   child:Container(
                     color: Colors.blue,
                     child: Padding(
                       padding: const EdgeInsets.only( left:15.0,right: 15.0),

                       child: Row(/*
            mainAxisAlignment: MainAxisAlignment.start,*/
                         children: [
                           InkWell(
                               onTap: (){
                                 Navigator.pop(context);
                               },
                               child: Icon(Icons.arrow_back,color: Colors.white )),
                           Padding(
                             padding: const EdgeInsets.only(left: 60.0, right: 40.0),
                             child: Text('Forgot Password',
                               style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white,),),
                           ),
                           /*Align(
                alignment: Alignment.center,
                child: Text('SIGN UP',textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white,),
              ),
              ),*/
                         ],
                       ),
                     ),
                     height: 55,
                     width: MediaQuery.of(context).size.width,
                     /*  height:*/
                   ),

                 ),
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
            SizedBox(height: size.height * 0.01,),  
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
      },
    );
  }

  
}