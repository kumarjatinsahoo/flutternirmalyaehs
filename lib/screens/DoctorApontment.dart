import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/Buttons.dart';
import 'package:user/widgets/text_field_container.dart';

class DoctorApontment extends StatefulWidget {
  MainModel model;

  DoctorApontment({
    Key key,
    this.model,
  }) : super(key: key);
  static KeyvalueModel selectGender;

  /*static ClinicModel selectClinic;*/

  @override
  _DoctorApontmentState createState() => _DoctorApontmentState();
}

class _DoctorApontmentState extends State<DoctorApontment> {
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
  //LoginResponse1 loginRes;
  TimeOfDay selectedTime = TimeOfDay.now();

  TimeOfDay slctTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*loginRes = widget.model.loginResponse1;
    DoctorApontment.selectClinic = null;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       /* title: Text(MyLocalizations.of(context).text("APPOINTMENT")),*/
        titleSpacing: 2,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.chevron_left)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Doctor Appointment for health checkup",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            /*  DropDown.networkDropdownGetpart1(
                  MyLocalizations.of(context).text("CLINIC"),
                  ApiFactory.CLINIC_LIST + loginRes.ashadtls[0].district_code,
                  "clinic", (ClinicModel data) {
                setState(() {
                  //DoctorApontment.selectClinic = data;
                  controller[0].text = data.clinicAddress;
                });
              }),*/
              textFieldDisable(controlI: 0, hint: "Address of clinic"),
              textFieldAll(controlI: 3,hint: "Doctor name"),
              appointmentDt(),
              appointmentTime(),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Buttons.nextButton(
                    function: () {
                      //validate();
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

  /*validate() {
    if (DoctorApontment.selectClinic == "" ||
        DoctorApontment.selectClinic == null) {
      AppData.showInSnackBar(context, "Please select clinic");
    } else if (controller[3].text == "") {
      AppData.showInSnackBar(context, "Enter doctor name");
    } else if (controller[1].text == "") {
      AppData.showInSnackBar(context, "Please select appointment date");
    } else if (controller[2].text == "") {
      AppData.showInSnackBar(context, "Please select appointment time");
    } else {
      loading();
      saveDb();
    }
  }*/

  loading() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
  }


  Widget textFieldAll({int controlI, String hint}) {
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

  saveDb() {
   /* regNo
    cntrid
    docnm
    docclinicnm
    docclinicaddrss
    appdt
    appnttime*/
    Map<String, dynamic> map = {
      //"id": widget.model.checkupId,
      "appdt": controller[1].text,
      "appnttime": controller[2].text,
      "docnm": controller[3].text,
     // "clinicid": DoctorApontment.selectClinic.id,
    };
   /* widget.model.POSTMETHOD(
        api: ApiFactory.DOCTOR_APPOINTMENT_CKUP,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.popup(context, map[Const.MESSAGE],(){
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
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
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    //if (picked_s != null && picked_s != selectedTime)
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
          //UpperCaseTextFormatter(),
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

  Widget textFieldDisable({int controlI, String hint}) {
    return TextFieldContainer(
      child: TextFormField(
        enabled: false,
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
