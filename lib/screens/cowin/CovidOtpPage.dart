
import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class CovidOtpPage extends StatefulWidget {
  final MainModel model;

  const CovidOtpPage({Key key, this.model}) : super(key: key);

  @override
  _CovidOtpPageState createState() => _CovidOtpPageState();
}

class _CovidOtpPageState extends State<CovidOtpPage> {
  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  //String txtId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  callApi() {
    var bytes1 = utf8.encode(controller[1].text);         // data being hashed
    var digest1 = sha256.convert(bytes1);         // Hashing Process
    print("Digest as bytes: ${digest1.bytes}");   // Print Bytes
    print("Digest as hex string: $digest1");
    Map<String,dynamic> postData = {"otp": digest1.toString(), "txnId": widget.model.txnId};
    log("Post Data>>>>>"+jsonEncode(postData));
    widget.model.POSTMETHOD(
        api: ApiFactory.CONFIRM_OTP,
        json: postData,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map.containsKey("token")) {
            log("Token>>>>>"+map["token"].toString());
          } else {
            AppData.showInSnackBar(context, "Something went wrong");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile No',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [mobileNumber("OTP", 1)],
      ),
    );
  }

  Widget mobileNumber(String hint, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "DINReg",
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 15, right: 15, top: 6.0, bottom: 15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[400], width: 1)),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  // enabled: widget.isConfirmPage ? false : true,
                  controller: controller[index],
                  //cursorColor: Const.primaryColor,
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                  style: TextStyle(fontSize: 13),
                  keyboardType: TextInputType.number,
                  //textAlignVertical: TextAlignVertical.center,
                  onFieldSubmitted: (v){
                    MyWidgets.showLoading(context);
                    callApi();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    //hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*suffixIcon: Icon(
                      Icons.phone,
                      size: 19,
                      color: Colors.grey,
                    ),*/
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
