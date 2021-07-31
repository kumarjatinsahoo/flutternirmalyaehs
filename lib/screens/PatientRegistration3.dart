import 'package:image_picker/image_picker.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:user/widgets/text_field_container.dart';


class PatientRegistration3 extends StatefulWidget {
  final MainModel model;

  const PatientRegistration3({Key key, this.model}) : super(key: key);
  @override
  _PatientRegistration3State createState() => _PatientRegistration3State();
}

class _PatientRegistration3State extends State<PatientRegistration3> {
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
                 Text(
                   'Profile',
                   style: TextStyle(color: Colors.black,fontSize: 20),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: formField(8, "Height(CM)"),
                 ),
                 SizedBox(height: size.height * 0.01,),

             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: formField(8, "Weight(CM)"),
             ),
                 SizedBox(height: size.height * 0.01,),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: formField(8, "Email"),
                 ),
          SizedBox(height: size.height * 0.07,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _submitButton(),
               ),
                 SizedBox(height: size.height * 0.20,),
             Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
               child:Align(
                 alignment: Alignment.bottomRight,
                 child: FloatingActionButton(
                   child: Icon(Icons.arrow_back_ios),
                   backgroundColor: Colors.orange,
                   heroTag: 1,
                   onPressed: () {
                     Navigator.pushNamed(context, "/patientRegistration");
                     //do something on press
                   },
                 ),
               ),

             )]),)

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
              //hintText:"Patient Name",
              hintText:hint,
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
        Navigator.pushNamed(context, "/navigation");
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