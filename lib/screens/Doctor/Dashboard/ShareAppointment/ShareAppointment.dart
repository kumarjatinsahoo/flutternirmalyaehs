import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MonthlyoverviewModel.dart' as monthly;
import 'package:user/models/ShareApntModel.dart';
import 'package:user/models/ShareModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class ShareAppointment extends StatefulWidget {
  MainModel model;
  static ShareApntModel shareappontmentmodel = null;
  static KeyvalueModel doctorreceptionmodel = null;

  ShareAppointment({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShareAppointment();
}
enum RadioGroup { payonshop, home }
enum RadioGroup1 { payon_shop, online }
class _ShareAppointment extends State<ShareAppointment> {
  DateTime selectedDate = DateTime.now();

  // apnt.AppointmentlistModel appointmentlistModel;
  //LoginResponse1 loginResponse;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  TextEditingController _reason = TextEditingController();
  String selectedDatestr;
  bool isdata = false;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  monthly.MonthlyOverviewModel monthlyOverviewModel;
  LoginResponse1 loginResponse;
  RadioGroup radioGroup = RadioGroup.payonshop;
  RadioGroup1 radioGroup1 = RadioGroup1.payon_shop;
  String roleid = "2";

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
  }


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).text("SHARE_APPOINTMENT")),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
              DropDown.sharenetworkDropdownGetpartUser("UHID",
                  ApiFactory.SHARE_APPOINTMENT_UHID+loginResponse.body.user,widget.model.token,
                  "shareappointment",
                  Icons.location_on_rounded,
                  23.0, (ShareApntModel data) {
                setState(() {
                  print(ApiFactory.SHARE_APPOINTMENT_UHID);
                   ShareAppointment.shareappontmentmodel = data;
                });
              }),
              SizedBox(height: 8),

              Container(
                height: 20,
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: RadioGroup1.payon_shop,
                          groupValue: radioGroup1,
                          onChanged: (RadioGroup1 value) {
                            setState(() {
                              radioGroup1 = value;
                              roleid = "2";
                              //bookPostModel.paymentway = "0";
                            });
                          },
                        ),
                        Text(MyLocalizations.of(context).text("DOCTOR"),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                    SizedBox(width:100),
                    Row(
                      children: [
                        Radio(
                          value: RadioGroup1.online,
                          groupValue: radioGroup1,
                          onChanged: (RadioGroup1 value) {
                            setState(() {
                              radioGroup1 = value;
                               roleid = "5";
                              //bookPostModel.paymentway = "1";
                            });
                          },
                        ),
                        Text(MyLocalizations.of(context).text("RECEPTIONIST"),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              DropDown.networkDropdownGetpartUser1(
                  MyLocalizations.of(context).text("NAME"),
                  ApiFactory.SHARE_APPOINTMENT_DOCTORRECEPTIONIST +loginResponse.body.user+"&roleid="+roleid,
                  "doctorreceptionist",
                  Icons.location_on_rounded,
                  23.0, (KeyvalueModel data) {
                setState(() {
                  print(ApiFactory.SHARE_APPOINTMENT_DOCTORRECEPTIONIST);
                  ShareAppointment.doctorreceptionmodel = data;
                });
              }),
              SizedBox(height: 8),
              formField(1, MyLocalizations.of(context).text("NOTES")),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  if (ShareAppointment.shareappontmentmodel == null ||
                      ShareAppointment.shareappontmentmodel == "") {
                    AppData.showInSnackBar(context, "Please select UHID ");
                  }else if (ShareAppointment.doctorreceptionmodel == null ||
                      ShareAppointment.doctorreceptionmodel == "") {
                    AppData.showInSnackBar(context, "Please select Doctor/Receptionlist Name ");
                  }  else if (_reason.text == "" || _reason.text == null) {
                    AppData.showInSnackBar(context, "Please enter Notes");
                  }else {
                    MyWidgets.showLoading(context);
                    ShareModel sharemodel = ShareModel();
                    sharemodel.drid = ShareAppointment.doctorreceptionmodel.key;
                    sharemodel.patientid = ShareAppointment.shareappontmentmodel.userid;
                    sharemodel.refdrid = loginResponse.body.user;
                    sharemodel.appno = ShareAppointment.shareappontmentmodel.appno;
                    sharemodel.notes = _reason.text;

                    widget.model.POSTMETHOD2(
                      api: ApiFactory.POST_SHARE_APPOINTMENT,
                      json: sharemodel.toJson(),
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        Navigator.pop(context);
                          if (map["code"] == Const.SUCCESS) {
                            Navigator.pop(context);
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);


                          } else {
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                      },
                    );
                  }
                },
                child: Material(
                  elevation: 5,
                  color: AppData
                      .kPrimaryColor,
                  borderRadius:
                  BorderRadius
                      .circular(
                      3.0),
                  child:
                  MaterialButton(
                    minWidth: 200,
                    height: 50.0,
                      child:  Text(
                        MyLocalizations.of(context).text("SHARE"),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold,
                              fontSize:
                              17,
                              color: Colors
                                  .white),
                        ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget formField(int index,
      String hint,) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: _reason,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }
}