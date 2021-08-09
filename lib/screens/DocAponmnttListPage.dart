import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/text_field_container.dart';


class DocAponmnttListPage extends StatefulWidget {
  MainModel model;

  DocAponmnttListPage({Key key, this.model}) : super(key: key);

  @override
  _DocAponmnttListPageState createState() => _DocAponmnttListPageState();
}

class _DocAponmnttListPageState extends State<DocAponmnttListPage> {
 /* DocApntModel regDataModel;
  LoginResponse1 loginResponse;*/
  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  @override
  void initState() {
    //loginResponse = widget.model.loginResponse1;
    super.initState();
    callApi();
    new Future.delayed(Duration.zero, () {
      AppData.loading(context);
    });
  }

  callApi() {
    /*widget.model.GETMETHODCALL(
        api: ApiFactory.LIST_DOC_APNT + widget.model.userid,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            setState(() {
              regDataModel = DocApntModel.fromJson(map);
            });
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  List<String> header = [
    "Reschedule",
    "Update visit",
    "Update test report",
  ];

  DateTime selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Doctor Appointments",
              style: TextStyle(color: Colors.white),
            ),
            /* Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/addScheduleHealth")
                        .then((value) {
                      if (value) callApi();
                    });
                  },
                  child: Icon(Icons.add_circle)),
            )*/
          ],
        ),
        titleSpacing: 2,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body:
          ListView.builder(
              itemBuilder: (context, i) {
                //Docappntdtls patient = regDataModel.docappntdtls[i];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            (i + 1).toString() + ". " /*+ (patient.clinicName??"")*/,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                           /* getRow("Clinic Address", patient.clinicAddress??""),
                            getRow("Doctor Name", patient.docName??""),
                            getRow("Date", patient.apptDate??""),
                            getRow("Time", patient.apptTime??""),*/
                          ],
                        ),
                        //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                        //trailing: Icon(Icons.menu_sharp),
                      ),
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: PopupMenuButton(
                          iconSize: 19,
                          onSelected: (v) {
                            //AppData.showInSnackBar(context, header[int.tryParse(v)]);
                            switch (v) {
                              case "0":
                                controller[0].text = "";
                                controller[1].text = "";
                                //showReschedule(context, patient);
                                break;
                              case "1":
                                controller[0].text = "";
                                controller[1].text = "";
                                controller[2].text = "";
                                //showUpdateVisit(context, patient);
                                break;
                              case "2":
                                break;
                              case "3":
                                //widget.model.checkupId = patient.id;
                                Navigator.pushNamed(context, "/docAppont");
                                break;
                            }
                          },
                          itemBuilder: (context) {
                            return List.generate(
                              header.length,
                              (index) {
                                return PopupMenuItem(
                                  child: Text(header[index]),
                                  value: index.toString(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                  ],
                );
              },
              //itemCount: regDataModel.docappntdtls.length,
            )
         /* : Container(),*/
    );
  }

  void showReschedule(BuildContext context, /*Checkupappointmnt apnt*/) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              "Reschedule",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                appointmentDt("Appointment date"),
                appointmentTime("Appointment time")
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("",
                  /*MyLocalizations.of(context).text("CANCEL"),*/
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  if (controller[0].text == "") {
                    AppData.showInSnackBar(context, "Select schedule new date");
                  } else if (controller[1].text == "") {
                    AppData.showInSnackBar(context, "Select schedule new time");
                  } else {
                    Map<String, dynamic> map = {
                      /*"id": apnt.id,*/
                      "apponttime": controller[1].text,
                      "appontdt": controller[0].text,
                    };
                    /*widget.model.POSTMETHOD(
                      api: ApiFactory.EDIT_CHKUP,
                      json: map,
                      fun: (Map<String, dynamic> map) {
                        if (map[Const.STATUS] == Const.SUCCESS) {
                          AppData.loading(context);
                          callApi();
                        } else
                          AppData.showInSnackBar(context, map[Const.MESSAGE]);
                      },
                    );*/
                  }
                },
              ),
            ],
          );
        });
  }

  void showUpdateVisit(BuildContext context, /*Checkupappointmnt apnt*/) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              "Update Visit",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textFieldAll(controlI: 2, hint: "Doctor/Nurse Name"),
                  appointmentDt("Checking Date"),
                  appointmentTime("Checking Time"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("",
                  /*MyLocalizations.of(context).text("CANCEL"),*/
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  if (controller[2].text == "") {
                    AppData.showInSnackBar(context, "Enter doctor/nurse name");
                  } else if (controller[0].text == "") {
                    AppData.showInSnackBar(context, "Select schedule new date");
                  } else if (controller[1].text == "") {
                    AppData.showInSnackBar(context, "Select schedule new time");
                  } else {
                    http: //localhost/matrujyoti/api/post-updateChkUpVisit?regNo=REG/2020-2021/000042&cntrid=4&nursenm=Sukanti Bag&chkupdt=09/05/2021&chktime=07:00 AM
                    Map<String, dynamic> map = {
                      /*"cntrid": apnt.id,
                      "regNo": widget.model.userid,*/
                      "nursenm": controller[2].text,
                      "chktime": controller[1].text,
                      "chkupdt": controller[0].text,
                    };
                   /* widget.model.POSTMETHOD(
                      api: ApiFactory.UPDATE_HEALTH_CHKUP,
                      json: map,
                      fun: (Map<String, dynamic> map) {
                        if (map[Const.STATUS] == Const.SUCCESS) {
                          AppData.loading(context);
                          callApi();
                        } else
                          AppData.showInSnackBar(context, map[Const.MESSAGE]);
                      },
                    );*/
                  }
                },
              ),
            ],
          );
        });
  }

  Widget textFieldAll({int controlI, String hint}) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller[controlI],
        keyboardType: TextInputType.text,
        inputFormatters: [/*  UpperCaseTextFormatter(),*/

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

  Future<Null> _selectDate(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now().add(new Duration(days: 1)),
        firstDate: DateTime.now().add(new Duration(days: 1)),
        lastDate:
            DateTime.now().add(Duration(days: 30))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      final df = new DateFormat('dd/MM/yyyy');
      selectedDate = picked;

      switch (comeFrom) {
        case "dob":
          controller[0].value = TextEditingValue(text: df.format(selectedDate));
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

    // if (picked_s != null && picked_s != selectedTime)
    setState(() {
      selectedTime = picked_s;

      switch (comeFrom) {
        case "dob":
          controller[1].text = formatTimeOfDay(picked_s);
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

  Widget appointmentDt(String hint) {
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
              controller: controller[0],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hint,
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

  Widget appointmentTime(String hint) {
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
              controller: controller[1],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hint,
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

  Widget getRow(String name, String value) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.black),
            ),
            Text(value),
          ],
        ),
      ],
    );
  }

  goWhere(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyWidgets.headerr(
                              "Click yes for account section & No for user details",
                              Alignment.bottomCenter),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black,
                        ),*/
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, "/AccountDetails");
                                  Navigator.pop(context);
                                  //Navigator.pushNamed(context, "/patientDetail");
                                  Navigator.pushNamed(context, "/ashaDash");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      Icons.account_circle_outlined,
                                      size: 40,
                                    ),
                                    /*Text(MyLocalizations.of(context).text("PERSONAL_DETAILS")),*/
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 80,
                                child: VerticalDivider(
                                  color: Colors.black,
                                )),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, "/AccountDetails");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 40,
                                    ),
                                  /*Text(MyLocalizations.of(context).text("ACCOUNT_DETAILS")),*/
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                          child: Text(
              "",
                         /*   MyLocalizations.of(context).text("CANCEL"),*/
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
