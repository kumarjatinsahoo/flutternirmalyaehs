import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:user/widgets/text_field_container.dart';

class PatientRegistration2 extends StatefulWidget {
  final MainModel model;
 // static KeyvalueModel genderModel = null;

  const PatientRegistration2({Key key, this.model}) : super(key: key);

  @override
  _PatientRegistration2State createState() => _PatientRegistration2State();
}

class _PatientRegistration2State extends State<PatientRegistration2> {
  var selectedMinValue;
  File pathUsr = null;

//  bool _enabled;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),

  ];
  bool _value = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        /*leading: BackButton(
              color: Colors.white,
            ),*/
        title: Text(MyLocalizations.of(context).text("PATIENT_REGISTRATION"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(MyLocalizations.of(context).text("PROFILE"),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: formField(0, MyLocalizations.of(context).text("AGE")),
                  ),
                  //SizedBox(height: size.height * 0.01,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* Expanded(
                        flex: 5,*/
                        Text(
                          MyLocalizations.of(context).text("GENDER"),
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        new Spacer(),
                        /* ),*/

                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: _normalToggleButton(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _submitButton(),
                  ),
                  SizedBox(
                    height: size.height * 0.20,
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget _normalToggleButton() {
    return Container(
      child: Transform.scale(
        scale: 1.5,
        child: Switch(
          //activeColor: Colors.pinkAccent,
          inactiveTrackColor: Colors.pinkAccent,
          activeTrackColor: AppData.kPrimaryColor,
          //inactiveThumbColor: Colors.green,

          value: _value,
          activeThumbImage: AssetImage("assets/man.png",),
          inactiveThumbImage: AssetImage("assets/women.png"),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (bool value) {
            print("VALUE : $value");
            setState(() {
              _value = value;
              if(value==false) {
                widget.model.patientgender = "2";
              }else{
                widget.model.patientgender = "1";

              }
            });
          },
        ),
      ),
    );
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
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
                offset: Offset(1.0, 1.0), //shadow direction: bottom right
              )
            ],
          ),
          child: TextFormField(
            //enabled: widget.isConfirmPage ? false : true,
            controller: textEditingController[index],
            //focusNode: fnode7,
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            maxLength: 2,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[0-9 ]")),
            ],
            decoration: InputDecoration(
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,
              counterText: "",
              //hintText:"Patient Name",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26, fontSize: 17),
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),
        ) /*),*/
        );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("NEXT").toUpperCase(),
      context: context,
      fun: () {
        widget.model.patientgender=_value?"1":"2";
        if (textEditingController[0].text == "" || textEditingController[0].text== null) {
          AppData.showInSnackBar(context, "Please enter age");
        } else if (textEditingController[0].text != "" && textEditingController[0].text== "0") {
            AppData.showInSnackBar(context, "Please enter a valid age");
        }  else {
          widget.model.patientage = textEditingController[0].text;
          Navigator.pushNamed(context, "/patientRegistration3");

        }
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
