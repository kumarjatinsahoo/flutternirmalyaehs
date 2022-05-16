import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LabBookModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';


class TestAppointmentPage1 extends StatefulWidget {
  final bool isConfirmPage;
  MainModel model;

  TestAppointmentPage1({
    Key key,
    this.model,
    this.isConfirmPage = false,
  }) : super(key: key);

  @override
  _TestAppointmentPage1State createState() => _TestAppointmentPage1State();
}

class _TestAppointmentPage1State extends State<TestAppointmentPage1>
    with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // LoginResponse1 loginResponse;
  LabBookModel appointModel;

  Color bgColor = Colors.white;
  Color txtColor = Colors.black;
  bool isOnline = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  String time;
  TextEditingController height = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController shiftname_ = new TextEditingController();
  TextEditingController starttime_ = new TextEditingController();
  TextEditingController endtime_ = new TextEditingController();
  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];
  String today;
  String comeFrom;

  static const platform = AppData.channel;
  List<Body> foundUser;

  @override
  void initState() {
    super.initState();
    //loginResponse = widget.model.loginResponse1;
    WidgetsBinding.instance.addObserver(this);

    /* ConnectionStatusSingleton connectionStatus =
    ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOnline = connectionStatus.hasConnection;
    });*/
    comeFrom = widget.model.apntUserType;
    final df = new DateFormat('dd/MM/yyyy');
    //final df = new DateFormat('yyyy/MM/dd');
    today = df.format(DateTime.now());
    callAPI(today);
    //printInterger()
  }

  bool isDataNotAvail = false;

  Future<void> _callLabApp(String data) async {
    try {
      final int result = await platform.invokeMethod('iLab', data);
    } on PlatformException catch (e) {}
  }

  callAPI(String today) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.HEALTH_SCREENING_LIST + today,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              appointModel = LabBookModel.fromJson(map);
              foundUser = appointModel.body;
            } else {
              isDataNotAvail = true;
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
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
      isDataNotAvail = false;
      final df = new DateFormat('dd/MM/yyyy');
      //final df = new DateFormat('yyyy/MM/dd');
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

  void _runFilter(String enteredKeyword) {
    List<Body> results = [];
    if (enteredKeyword.isEmpty) {
      results = appointModel.body;
    } else {
      results = appointModel.body
          .where((user) => user.patientName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()) ||  user.regNo
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundUser = results;
    });
  }

  bool isSearchShow = false;

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
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text(
                MyLocalizations.of(context).text("TESTS"),
                style: TextStyle(color: bgColor),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSearchShow = !isSearchShow;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(!isSearchShow
                    ? Icons.search
                    : Icons.highlight_remove_rounded),
              ),
            )
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
                  height: 3,
                ),
                (isSearchShow)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: TextField(
                            onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                hintText: MyLocalizations.of(context).text("SEARCH")),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 8,
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
                                text:"   " + MyLocalizations.of(context).text("APPOINTMENT").toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
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
                          MyLocalizations.of(context).text("REG_NO"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          MyLocalizations.of(context).text("NAME"),
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
                          MyLocalizations.of(context).text("AGE"),
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
                          MyLocalizations.of(context).text("GENDER"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          MyLocalizations.of(context).text("STATUS"),
                          textAlign: TextAlign.center,
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
                        itemCount: foundUser.length,
                        itemBuilder: (context, index) {

                          //String ageFirst=foundUser[index]?.gender[0];
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
                                        foundUser[index].regNo,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Text(
                                        foundUser[index].patientName,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
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
                                      width: 60,
                                      child: Text(
                                        foundUser[index].age.toString(),
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
                                        (foundUser[index]?.gender!=null)?foundUser[index]?.gender[0]:"",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {
                                          /*showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  dialogRegNo(context,
                                                      foundUser[index]));*/
                                          widget.model.bodyUser=foundUser[index];
                                          Navigator.pushNamed(context, "/vitalDoctor");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.0)),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 3),
                                          child: Text(
                                            foundUser[index].appntmntStatus,
                                            style: TextStyle(
                                                color: Colors.green,
                                                decoration:
                                                    TextDecoration.underline),
                                            textAlign: TextAlign.center,
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
                              child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
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

  Widget dialogRegNo(BuildContext context, Body body) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    height.text = "";
    weight.text = "";
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
                  "FILL UP DETAILS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  child: Divider(
                    height: 2,
                  ),
                  width: 180,
                ),
                Text(
                  "(" + body.patientName + ")",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                fromFieldNew("Height(In CM)", TextInputAction.next,
                    TextInputType.number, "name", height),
                fromFieldNew("Weight(In KG)", TextInputAction.next,
                    TextInputType.number, "name", weight),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
         FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
         FlatButton(
          onPressed: () {
            if (height.text == "" || height.text == null) {
              AppData.showInSnackBar(context, "Please enter height");
            } else if (weight.text == "" || weight.text == null) {
              AppData.showInSnackBar(context, "Please enter weight");
            } else {
              String mob =
                  (body.mob == null || body.mob == "" || body.mob == "null")
                      ? ""
                      : body.mob;
              String mapping = body.regNo.trim() +
                  "," +
                  body.patientName.trim() +
                  "," +
                  mob.trim() +
                  "," +
                  body.gender +
                  "," +
                  height.text +
                  "," +
                  weight.text +
                  "," +
                  body.age.toString().trim();
              _callLabApp(mapping.trim());
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],
    );
  }

  String removeFirstandLast(String str1) {
    String str = str1.substring(1, str1.length - 1);
    return str;
  }

  Widget changeStatus(BuildContext context, Body userName, int i) {
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
          child: const Text('CANCEL'),
        ),
      ],
    );
  }

  updateApi(String id, String statusCode, int i) {
    MyWidgets.showLoading(context);
    Map<String, dynamic> mapPost = {"id": id, "appontstatus": statusCode};
    if (widget.model.apntUserType == Const.HEALTH_SCREENING_APNT) {
      widget.model.POSTMETHOD(
          api: ApiFactory.CHANGE_STATUS_SCREENING,
          json: mapPost,
          fun: (Map<String, dynamic> map) {
            setState(() {
              Navigator.pop(context);
              Navigator.pop(context);
              String msg = map[Const.MESSAGE];
              if (map[Const.STATUS] == Const.SUCCESS) {
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
      widget.model.POSTMETHOD(
          api: ApiFactory.CHANGE_STATUS_CHKUP,
          json: mapPost,
          fun: (Map<String, dynamic> map) {
            setState(() {
              Navigator.pop(context);
              Navigator.pop(context);
              String msg = map[Const.MESSAGE];
              if (map[Const.STATUS] == Const.SUCCESS) {
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

  Widget fromFieldNew(String hint, inputAct, keyType, String type,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        inputFormatters: [
          //UpperCaseTextFormatter(),
        ],
        maxLength: 3,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
