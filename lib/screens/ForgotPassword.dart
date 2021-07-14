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