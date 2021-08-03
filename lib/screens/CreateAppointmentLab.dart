import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/Buttons.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

class CreateAppointmentLab extends StatefulWidget {
  MainModel model;

  CreateAppointmentLab({
    Key key,
    this.model,
  }) : super(key: key);
  static KeyvalueModel selectGender;

 // static ClinicModel selectClinic;

  @override
  _CreateAppointmentLabState createState() => _CreateAppointmentLabState();
}

class _CreateAppointmentLabState extends State<CreateAppointmentLab> {
  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<KeyvalueModel> genderList = [
    KeyvalueModel(key: "0", name: "MALE"),
    KeyvalueModel(key: "1", name: "FEMALE"),
    KeyvalueModel(key: "2", name: "TRANSGENDER"),
  ];

  DateTime selectedDate;
 // LoginResponse1 loginRes;
  TimeOfDay selectedTime = TimeOfDay.now();

  TimeOfDay slctTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // loginRes = widget.model.loginResponse1;
    //CreateAppointmentLab.selectClinic = null;

    final df = new DateFormat('dd/MM/yyyy');
    controller[1].text = df.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.matruColor,
        title: Row(
          children: [
            Text(
              widget.model.apntUserType == Const.HEALTH_SCREENING_APNT
                  ? "Health Screening"
                  : "Health Checkup",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            /*  InkWell(
                onTap: () {

                  //Navigator.pushNamed(context, "/userProfile");
                },
                child: Text(
                  "Appointment History",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                )),*/
            SizedBox(
              width: 10,
            )
          ],
        ),
        titleSpacing: 2,
        /*leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.chevron_left)),*/
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              MyWidgets.header1("User Details", Alignment.center),
              Divider(),
              rowData(
                  "User Name", widget.model.userModel.reglist[0].name ?? ""),
              rowData("Reg No.", widget.model.userModel.reglist[0].regNo ?? ""),
              rowData("Father/Husband Name",
                  widget.model.userModel.reglist[0].husbandorfather ?? ""),
              rowData("District",
                  widget.model.userModel.reglist[0].districtnm ?? ""),
              rowData("Gender", widget.model.userModel.reglist[0].gender ?? ""),
              rowData("Mobile No",
                  widget.model.userModel.reglist[0].mobileNo ?? ""),

              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyWidgets.header1(MyLocalizations.of(context).text("APPOINTMENT"), Alignment.topLeft),
              ),
              SizedBox(
                height: 4,
              ),
              appointmentDt(),
              appointmentTime(),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Buttons.nextButton(
                    function: () async {
                      validate();
                      //Share.
                      /*print("DATA");
                      await LaunchApp.openApp(
                          androidPackageName:
                              'com.nirmanshramik.ConstructionWorker');*/
                    },
                    title: "SCHEDULE",
                    context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowData(String txt, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
            //textAlign: TextAlign.left,
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  validate() {
    if (widget.model.userModel == null) {
      AppData.showInSnackBar(context, "Something went wrong please go back");
    } else if (controller[1].text == "") {
      AppData.showInSnackBar(context, "Please select appointment date");
    } else if (controller[2].text == "") {
      AppData.showInSnackBar(context, "Please select appointment time");
    } else {
      loading();
      saveDb();
    }
  }

  loading() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  saveDb() {
    //regNo=REG/2020-2021/000042&appontdt=12/06/2021&apponttime=10:00AM
    Map<String, dynamic> map = {
      "regNo": widget.model.userModel.reglist[0].regNo,
      "appontdt": controller[1].text,
      "apponttime": controller[2].text,
    };
    if (widget.model.apntUserType == Const.HEALTH_SCREENING_APNT) {
      widget.model.POSTMETHOD(
          api: ApiFactory.POST_HEALTH_SCREEN,
          json: map,
          fun: (Map<String, dynamic> map) {
            //Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              //Navigator.pop(context, true);
              popup(map[Const.MESSAGE], context);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
    } else {
      widget.model.POSTMETHOD(
          api: ApiFactory.POST_HEALTH_CHCKUP,
          json: map,
          fun: (Map<String, dynamic> map) {
            //Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              //Navigator.pop(context, true);
              popup(map[Const.MESSAGE], context);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
    }
  }

  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
        desc: msg,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Future<Null> _selectDate(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(days: 276))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      final df = new DateFormat('dd/MM/yyyy');
      selectedDate = picked;

      switch (comeFrom) {
        case "dob":
          controller[1].value = TextEditingValue(text: df.format(selectedDate));
          break;
      }
    });
  }

  Future<void> _selectTime(BuildContext context, String comeFrom) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          /*return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );*/
          return Localizations.override(
            context: context,
            locale: Locale('en'),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        slctTime = picked_s;

        switch (comeFrom) {
          case "dob":
            controller[2].text = formatTimeOfDay(selectedTime);
            break;
        }
      });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Widget appointmentDt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () => _selectDate(context, "dob"),
        child: AbsorbPointer(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              controller: controller[1],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Appointment date",
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appointmentTime() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () => _selectTime(context, "dob"),
        child: AbsorbPointer(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              controller: controller[2],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Appointment Time",
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({int controlI, String hint}) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller[controlI],
        keyboardType: TextInputType.text,
        inputFormatters: [
         // UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget textFieldAll({int controlI, String hint}) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller[controlI],
        keyboardType: TextInputType.text,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget textFieldDisable({int controlI, String hint}) {
    return TextFieldContainer(
      child: TextFormField(
        enabled: false,
        controller: controller[controlI],
        keyboardType: TextInputType.text,
        inputFormatters: [
        //  UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget textFieldNumber({int controlI, String hint, int number}) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller[controlI],
        keyboardType: TextInputType.phone,
        maxLength: number,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp("[0-9]")),
        ],
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            counterText: ''),
      ),
    );
  }
}
