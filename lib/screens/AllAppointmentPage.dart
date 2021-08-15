import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LabBookModel.dart' as lab;
import 'package:user/models/UserDetailsModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import 'CreateAppointmentLab.dart';

// ignore: must_be_immutable
class AllAppointmentPage extends StatefulWidget {
  final bool isConfirmPage;
  MainModel model;

  AllAppointmentPage({
    Key key,
    this.model,
    this.isConfirmPage = false,
  }) : super(key: key);

  @override
  _AllAppointmentPageState createState() => _AllAppointmentPageState();
}

class _AllAppointmentPageState extends State<AllAppointmentPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //LoginResponse1 loginResponse;
  lab.LabBookModel appointModel;

  StreamSubscription _connectionChangeStream;
  Color bgColor = Colors.white;
  Color txtColor = Colors.black;
  bool isOnline = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  String time;
  TextEditingController shiftname_ = new TextEditingController();
  TextEditingController starttime_ = new TextEditingController();
  TextEditingController endtime_ = new TextEditingController();
  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;
  String today;
  String comeFrom;
  bool isDataNotAvail = false;

  @override
  void initState() {
    super.initState();
    comeFrom = widget.model.apntUserType;
    //final df = new DateFormat('yyyy/MM/dd');
    final df = new DateFormat('dd/MM/yyyy');
    today = df.format(DateTime.now());
    callAPI(today);
  }

  callAPI(String today) {
    if (comeFrom == Const.HEALTH_SCREENING_APNT) {
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.HEALTH_SCREENING_LIST + today,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                appointModel = lab.LabBookModel.fromJson(map);
              } else {
                isDataNotAvail = true;
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    } else if (comeFrom == Const.HEALTH_CHKUP_APNT) {
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.HEALTH_CHKUP_LIST + today,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                appointModel = lab.LabBookModel.fromJson(map);
              } else {
                isDataNotAvail = true;
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 30)),
        lastDate:
            DateTime.now().add(Duration(days: 276))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      isDataNotAvail=false;
     //final df = new DateFormat('yyyy/MM/dd');
      final df = new DateFormat('dd/MM/yyyy');
      today = df.format(picked);
      callAPI(today);
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(
          color: bgColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Appointments",
              style: TextStyle(color: bgColor),
            ),
          ],
        ),
        titleSpacing: 2,
        backgroundColor: AppData.matruColor,
      ),
      body: SafeArea(
        child: Container(
          color: bgColor,
          margin: EdgeInsets.only(left: 5, right: 5),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 4),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: today,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _selectDate(context);
                                },
                            ),
                            TextSpan(
                                text: " Appointments",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        MyWidgets.toggleButton("NEW", () {
                          //Navigator.pushNamed(context, "/qrCode1");
                          //dialogRegNo(context);
                          //dialogPopup(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialogRegNo(context),
                          );
                        }),
                        MyWidgets.toggleButton1("REPORTS", () {
                          AppData.showInSnackBar(context, "Reports click");
                        }),
                      ],
                    ),

                    /*InkWell(
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialogaddShift(context),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(7, 1, 6, 1),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "NEW",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppData.grey,
                  height: 40.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          "Reg No",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          MyLocalizations.of(context).text("NAME"),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*Expanded(
                        child: Text(
                          "Age",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),*/
                      SizedBox(
                        width: 35,
                        child: Text(
                          "Age",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          "Gender",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Status",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                (appointModel != null &&
                        appointModel.body != null &&
                        appointModel.body.length > 0)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        itemCount: appointModel.body.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /*Expanded(
                                      child: Text(
                                        appointModel.appointList[index].id,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),*/
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        appointModel.body[index].regNo,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        appointModel.body[index].patientName,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    /*Expanded(
                                      child: Text(
                                        appointModel.appointList[index].age,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),*/
                                    SizedBox(
                                      width: 35,
                                      child: Text(
                                        appointModel.body[index].age.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        appointModel.body[index].gender[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                changeStatus(
                                                    context,
                                                    appointModel.body[index],
                                                    index),
                                          );
                                        },
                                        child: Container(
                                          child: Text(
                                            appointModel
                                                .body[index].appntmntStatus,
                                            style: TextStyle(
                                                color: Colors.green,
                                                decoration:
                                                    TextDecoration.underline),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                            ],
                          );
                        })
                    : (isDataNotAvail)
                        ? Container(
                            height: size.height - 100,
                            child: Center(
                              child: Text("Data Not Found"),
                            ),
                          )
                        : MyWidgets.loading(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dialogRegNo(BuildContext context) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    //shiftname_.text="";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "SEARCH BENEFICIARY",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                fromFieldNew(
                    "Beneficiary No",
                    widget.isConfirmPage,
                    TextInputAction.next,
                    TextInputType.text,
                    MyLocalizations.of(context).text("NAME"),
                    shiftname_),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          onPressed: () {
            // widget.model.QR_FROM = Const.APNT_CALL;
            Navigator.pushNamed(context, "/qrCode1");
          },
          textColor: Colors.grey[900],
          child: const Text('SCAN'),
        ),
        new FlatButton(
          onPressed: () {
            if (shiftname_.text == "" || shiftname_.text == null) {
              AppData.showInSnackBar(context, "Please enter beneficiary no");
            } else {
              MyWidgets.showLoading(context);
              widget.model.GETMETHODCALL_TOKEN(
                  api: ApiFactory.GET_BENE_DETAILS + shiftname_.text,
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    setState(() {
                      Navigator.of(context).pop();
                      //String msg = map[Const.MESSAGE];
                      if (map[Const.CODE] == Const.SUCCESS) {
                        /*Navigator.of(context).pop();
                        AppData.showInSnackBar(context, msg);*/
                        UserDetailsModel userModel =
                            UserDetailsModel.fromJson(map);
                        widget.model.userModel = userModel;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAppointmentLab(
                              model: widget.model,
                            ),
                          ),
                        ).then((value) {
                          if (value) {
                            callAPI(today);
                          }
                        });
                      } else {
                        //Navigator.of(context).pop();
                        AppData.showInSnackBar(context, map[Const.MESSAGE]);
                      }
                    });
                  });
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],
    );
  }

  Widget changeStatus(BuildContext context, lab.Body userName, int i) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 20),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "CHANGE STATUS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  userName.patientName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("BOOKED"),
                  leading: Icon(Icons.book),
                  onTap: () {
                    updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("In-Progress"),
                  leading: Icon(Icons.trending_up),
                  onTap: () {
                    updateApi(userName.id.toString(), "1", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("Completed"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
                    updateApi(userName.id.toString(), "2", i);
                  },
                )
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text(MyLocalizations.of(context).text("CANCEL")),
        ),
      ],
    );
  }

  updateApi(String id, String statusCode, int i) {
    MyWidgets.showLoading(context);
    Map<String, dynamic> mapPost = {"id": id, "appontstatus": statusCode};
    if (widget.model.apntUserType == Const.HEALTH_SCREENING_APNT) {
      widget.model.POSTMETHOD_TOKEN(
          api: ApiFactory.CHANGE_STATUS_SCREENING,
          json: mapPost,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              Navigator.pop(context);
              Navigator.pop(context);
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                  switch (statusCode) {
                    case "0":
                      appointModel.body[i].appntmntStatus = "Booked";
                      appointModel.body[i].appointStatus = 0;
                      break;
                    case "1":
                      appointModel.body[i].appntmntStatus = "In-Progress";
                      appointModel.body[i].appointStatus = 1;
                      break;
                    case "2":
                      appointModel.body[i].appntmntStatus = "Completed";
                      appointModel.body[i].appointStatus = 2;
                      break;
                  }
                });
              } else {
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    } else {
      widget.model.POSTMETHOD_TOKEN(
          api: ApiFactory.CHANGE_STATUS_CHKUP,
          json: mapPost,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              Navigator.pop(context);
              Navigator.pop(context);
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                  switch (statusCode) {
                    case "0":
                      appointModel.body[i].appntmntStatus = "Booked";
                      appointModel.body[i].appointStatus = 0;
                      break;
                    case "1":
                      appointModel.body[i].appntmntStatus = "In-Progress";
                      appointModel.body[i].appointStatus = 1;
                      break;
                    case "2":
                      appointModel.body[i].appntmntStatus = "Completed";
                      appointModel.body[i].appointStatus = 2;
                      break;
                  }
                });
              } else {
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    }
  }

  Widget fromFieldNew(String hint, bool enb, inputAct, keyType, String type,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        inputFormatters: [
          /* AppData.*/
          //  UpperCaseTextFormatter(),
        ],
        decoration: InputDecoration(
          //prefixIcon: Icon(Icons.insert_drive_file_outlined),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
          /*enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),*/
        ),
      ),
    );
  }
}
