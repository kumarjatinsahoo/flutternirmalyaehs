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
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class ShareAppointment extends StatefulWidget {
  MainModel model;

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
  String btnName = "1";

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.MONTHLY_OVERVIEW + loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                monthlyOverviewModel =
                    monthly.MonthlyOverviewModel.fromJson(map);
              });
            } else {
              setState(() {
                // isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Overview'),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: (monthlyOverviewModel != null) ? Container(
        child: SingleChildScrollView(
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
                DropDown.networkDropdownGetpartUser1(
                    MyLocalizations.of(context).text("NAME"),
                    ApiFactory.ADM_EQUIPMENT_API,
                    "typelist",
                    Icons.location_on_rounded,
                    23.0, (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.ADM_EQUIPMENT_API);
                    // BiomediImplants.admequipmentmodel = data;
                  });
                }),
                SizedBox(height: 8),

                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: RadioGroup1.payon_shop,
                            groupValue: radioGroup1,
                            onChanged: (RadioGroup1 value) {
                              setState(() {
                                radioGroup1 = value;
                                btnName = "1";
                                //bookPostModel.paymentway = "0";
                              });
                            },
                          ),
                          Text(
                            "Pay on Shop",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: RadioGroup1.online,
                            groupValue: radioGroup1,
                            onChanged: (RadioGroup1 value) {
                              setState(() {
                                radioGroup1 = value;
                                 btnName = "2";
                                //bookPostModel.paymentway = "1";
                              });
                            },
                          ),
                          Text(
                            "Online",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                DropDown.networkDropdownGetpartUser1(
                    MyLocalizations.of(context).text("NAME"),
                    ApiFactory.ADM_EQUIPMENT_API,
                    "typelist",
                    Icons.location_on_rounded,
                    23.0, (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.ADM_EQUIPMENT_API);
                    // BiomediImplants.admequipmentmodel = data;
                  });
                }),
                SizedBox(height: 8),
                formField(1, "Notes"),
                SizedBox(height: 30),

                Material(
                  elevation: 5,
                  color: AppData
                      .kPrimaryColor,
                  borderRadius:
                  BorderRadius
                      .circular(
                      3.0),
                  child:
                  Expanded(
                    child: MaterialButton(
                      minWidth: 200,
                      height: 50.0,
                        child:  Text(
                            "Share",
                            style: TextStyle(
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontSize:
                                12,
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
      ) : Container(),
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