import 'package:image_picker/image_picker.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:user/widgets/text_field_container.dart';


class PatientRegistration extends StatefulWidget {
  final MainModel model;

  const PatientRegistration({Key key, this.model}) : super(key: key);
  @override
  _PatientRegistrationState createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  var selectedMinValue;
  File pathUsr = null;
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
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),

  ];
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
                'Patient Registration',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              iconTheme: IconThemeData(color: Colors.white),
            ),
           body: Stack(children: <Widget>[
           SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [    
                          SizedBox(height: size.height * 0.02,),
                 Align(
                   alignment: Alignment.topCenter,
                   child: Container(
                     height: 83,
                     width: 83,
                     child: Stack(
                       //mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         (pathUsr != null)
                             ? Material(
                           elevation: 5.0,
                           shape: CircleBorder(),
                           child: CircleAvatar(
                             radius: 40.0,
                             backgroundImage:
                             FileImage(pathUsr),
                           ),
                         )
                             : Material(
                           elevation: 5.0,
                           shape: CircleBorder(),
                           child: CircleAvatar(
                             radius: 40.0,
                             backgroundImage: NetworkImage(
                                 AppData.defaultImgUrl),
                           ),
                         ),
                         Align(
                           alignment: Alignment.bottomRight,
                           child: InkWell(
                             onTap: () {
                               getCameraImage();
                             },
                             child: Icon(
                               Icons.camera_alt,
                               color: AppData.kPrimaryColor,
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
              Padding(padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Expanded(
                       flex: 2,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8, right: 4,top: 10),
                         child: Container(
                           height: 47,
                           padding: EdgeInsets.symmetric(
                             horizontal: 5,
                           ),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(3),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey,
                                 blurRadius: 1.0,
                                 spreadRadius: 0.0,
                                 offset: Offset(1.0, 1.0),//shadow direction: bottom right
                               )
                             ],
                           ),
                          /* Padding(
                             padding: const EdgeInsets.only(left: 8),*/
                             child: Row(
                               children: [
                                  Padding(
                                     padding: const EdgeInsets.only(
                                         left: 5.0, right: 5.0),
                                     child: Image.asset("assets/indiaflagpng.png",height: 15,)),
                                 Text('IN' , style: TextStyle(color: Colors.black),),
                                 DropdownButton<String>(
                                   // hint: Text("Select Device"),
                                   underline: Container(
                                     color: Colors.grey,
                                   ),
                                   value: AppData.currentSelectedValue,
                                   isDense: true,
                                   onChanged: (newValue) {
                                     setState(() {
                                       AppData.currentSelectedValue = newValue;
                                     });
                                     print(AppData.currentSelectedValue);
                                   },
                                   items: AppData.phoneFormat.map((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value),
                                     );
                                   }).toList(),
                                 ),
                               ],
                             ),
                         ),
                       ),
                     ),
                     Expanded(
                       flex: 4,
                       child:Padding(
                           padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                           child: Container(
                           //color: Colors.white,
                           height: 47,
                           padding: EdgeInsets.symmetric(horizontal: 5,),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(3),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey,
                                 blurRadius: 1.0,
                                 spreadRadius: 0.0,
                                 offset: Offset(1.0, 1.0),//shadow direction: bottom right
                               )
                             ],
                           ),
                             child: TextFormField(
                                //enabled: widget.isConfirmPage ? false : true,
                               controller: textEditingController[4],
                                //focusNode: fnode7,
                               cursorColor: AppData.kPrimaryColor,
                               textInputAction: TextInputAction.next,
                               maxLength: 10,
                               keyboardType: TextInputType.number,
                               decoration: InputDecoration(
                                /* suffixIcon: Icon(Icons.phone),*/
                                 border: InputBorder.none,
                                 counterText: "",
                                 hintText:"Mobile Number",
                                 hintStyle: TextStyle(color:Colors.black26, fontSize: 17),
                               ),
                               onSaved: (value) {
                                 //userPersonalForm.phoneNumber = value;
                               },
                             ),
                           /*child: TextFormField(
                             enabled: false,
                             decoration:
                             InputDecoration(
                              *//* prefixIcon: Icon(Icons
                                   .calendar_today),*//*
                               border: InputBorder.none,
                               hintText: "Mobile Number",
                               hintStyle: TextStyle(
                                   color: Colors.black26,
                                   fontSize: 17),
                             ),
                             textAlignVertical: TextAlignVertical.center,
                             textInputAction: TextInputAction.next,
                             keyboardType: TextInputType.number,
                             //maxLength: 2,
                           ),*/
                         )/*),*/
                       ),
                     ),

                   ],
                 ),),
                 SizedBox(height: size.height * 0.02,),

             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: formField(8, "Education"),
             ),
          SizedBox(height: size.height * 0.07,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _submitButton(),
               ),
                 SizedBox(height: size.height * 0.20,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Align(
                     alignment: Alignment.centerRight,
                     child: Positioned(
                       top: 50,
                       left: 20,
                     child: FloatingActionButton(
                       child: Icon(Icons.arrow_back_ios),
                       backgroundColor: Colors.orange,
                       heroTag: 1,
                       onPressed: () {
                         //do something on press
                         Navigator.pop(context);
                        // Navigator.pushNamed(context, "/patientRegistration3");
                       },
                     ),),),
                 )
               ],),)

            ],),
           ),




        );
  }
  Widget formField(int index, String hint,) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
          height: 47,
          padding: EdgeInsets.symmetric(horizontal: 5,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0),//shadow direction: bottom right
              )
            ],
          ),
          child: TextFormField(
            //enabled: widget.isConfirmPage ? false : true,
            controller: textEditingController[4],
            //focusNode: fnode7,
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            maxLength: 10,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,
              counterText: "",
              hintText:"Patient Name",
              hintStyle: TextStyle(color:Colors.black26, fontSize: 17),
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),

        )/*),*/
    );
  }
  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "NEXT".toUpperCase(),
      context: context,
      fun: () {
        Navigator.pushNamed(context, "/patientRegistration2");
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

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(_path));

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);

      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
    }
  }
}