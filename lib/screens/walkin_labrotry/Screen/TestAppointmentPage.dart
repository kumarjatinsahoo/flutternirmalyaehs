import 'dart:async';
import 'dart:convert';
import 'dart:developer';
/*import 'dart:html';*/
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LabBookModel.dart';
import 'package:user/models/LoginResponse1.dart' as login;
import 'package:user/models/WritzoReceiveModel.dart';
import 'package:user/providers/Aes.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../../CreateAppointmentLab.dart';

// ignore: must_be_immutable
class TestAppointmentPage extends StatefulWidget {
  final bool isConfirmPage;
  MainModel model;
  static KeyvalueModel relationmodel = null;

  TestAppointmentPage({
    Key key,
    this.model,
    this.isConfirmPage = false,
  }) : super(key: key);

  @override
  _TestAppointmentPageState createState() => _TestAppointmentPageState();
}

class _TestAppointmentPageState extends State<TestAppointmentPage>
    with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // LoginResponse1 loginResponse;
  LabBookModel appointModel;

  StreamSubscription _connectionChangeStream;
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
  bool _isSignUpLoading = false;
  String today;
  String comeFrom;

  static const platform = AppData.channel;
  List<Body> foundUser;
  login.LoginResponse1 loginResponse1;

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
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
  var dio = Dio();
  Future<void> _callLabApp(String data) async {
    try {
      if (await Permission.storage.request().isGranted) {
        print("<<>>>>>writzoData>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
            data);
        Directory directory = await getExternalStorageDirectory();
        final Directory folder = Directory(directory.path + "/writzoFiles");
        if (!await folder.exists()) {
          folder.create();
        }
        log(folder.path);
        String data1 = data + "," + "${folder.path}";
        log("Whole Dataa>>>>>>" + data1);
        dynamic result = await platform.invokeMethod('writzo', data1);

        if (result != null) {
          try {
            WritzoReceiveModel writzoReceiveModel =
            WritzoReceiveModel.fromJson(json.decode(result));
            AppData.showInSnackDone1(context, result);
            log(writzoReceiveModel.screeningDetails[0].vitalName);
            List<ScreeningDetails> document = [];
            List<ScreeningDetails> value = [];
            var formData = FormData();
            formData.fields.add(
                MapEntry("patientId", writzoReceiveModel.patientId));
            formData.fields.add(MapEntry(
                "screeningDate", "1654253238098"));
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                File(writzoReceiveModel.screeningDetails[2].result).path);
            writzoReceiveModel.screeningDetails.forEach((element) {
              if (element.type == "file") {
                document.add(new ScreeningDetails(
                    type: element.type,
                    vitalName: element.vitalName,
                    result: File(element.result).path));
                print(File(element.result).path);
              } else {
                value.add(element);
              }
            });
            for (int i = 0; i < document.length; i++) {
              formData.fields.add(MapEntry(
                  "fileDetails[${i.toString()}].key", document[i].vitalName));
              formData.fields.add(MapEntry("fileDetails[${i.toString()}].ext",
                  AppData.getExt(document[i].result)));
              formData.files.add(MapEntry(
                  "fileDetails[${i.toString()}].file",
                  MultipartFile.fromFileSync(
                    document[i].result,
                    filename: document[i].result,
                  )));
            }
            for (int i = 0; i < value.length; i++) {
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].vitalName",
                  value[i].vitalName));
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].result", value[i].result));
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].type", value[i].type));
            }

            postFromWritzo(formData,
                ApiFactory.API_Writzo);
          }
          catch (e) {
            AppData.showInSnackDone(context, e.toString());
          }
        }
      }
      else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
        AppData.showInSnackBar(context, "Storage Permission Required");
      } else if (await Permission.storage.request().isDenied) {
        AppData.showInSnackBar(context, "Storage Permission Required");
        await Permission.storage.request();
      }
    } on PlatformException catch (e) {}
  }
  postFromWritzo(FormData formData, String Url) async {
    /*MyWidgets.showLoading(context);*/
    log("API call>>>>>>>>>>>" + Url);
    try {
      Response response;
      response = await dio.post(
        Url,
        data: formData,
        onSendProgress: (received, total) {
          if (total != -1) {
            /*  setState(() {
              print((received / total * 100).toStringAsFixed(0) + '%');
            });*/
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        },
      );
      // Navigator.pop(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("value" + jsonEncode(response.data));
        if (response.data["code"] == "success") {
          print("Data Saved Successfully");
          log( "Data Saved Successfully");
          AppData.showInSnackDone(context,"Data Saved Successfully");
          // Navigator.pop(context, true);
        } else {
          log( "Something went wrong ");
        }
      } else {
        // Navigator.pop(context);
        log( "Something went wrong");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log("Dio Error"+jsonEncode(e.response.data).toString());
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log("Dio Error"+jsonEncode(e.response.data).toString());
      }
      if (e.type == DioErrorType.DEFAULT) {
        log("Dio Error"+jsonEncode(e.response?.data?? "").toString());
      }
      if (e.type == DioErrorType.RESPONSE) {
        log("Dio Error"+jsonEncode(e.response.data).toString());
      }
    }
  }
  callAPI(String today) {
    log("Suvam----------" +ApiFactory.HEALTH_SCREENING_LIST + today + "&labid="
        +loginResponse1.body.user,);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.HEALTH_SCREENING_LIST + today + "&labid="+loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              log("Response>>>\n\n\n\n\n\n\n\n\n\n\n"+jsonEncode(map)+"\n\n\n\n\n\n\n\n\n\n\n");
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
      //key: _scaffoldKey,
      appBar: AppBar(
        // leading: BackButton(
        //   color: bgColor,
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 90.0),
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
                padding: const EdgeInsets.only(right: 15.0),
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
      body: Container(
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
                              hintText:MyLocalizations.of(context).text("SEARCH")),
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
                            text: "     ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Colors.black,
                             // decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _selectDate(context);
                              },
                          ),
                          TextSpan(
                              text: MyLocalizations.of(context).text("APPOINTMENT").toUpperCase(),
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
                                      (foundUser[index].age!=null)?foundUser[index].age.toString():"N/A",
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
                                      (foundUser[index].gender!=null)?foundUser[index].gender[0]:"N/A",
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
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                dialogRegNo(context,
                                                    foundUser[index]));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0)),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        alignment: Alignment.topLeft,
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
    );
  }

  Widget dialogRegNo(BuildContext context, Body body) {
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 13,right: 13),
                //   child: DropDown.networkDropdownGetpartUserundreline(
                //       "PHC/Center",
                //       ApiFactory.RELATION_API,
                //       "relation3", (KeyvalueModel model) {
                //     setState(() {
                //       TestAppointmentPage.relationmodel = model;
                //     });
                //   }),
                // ),
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
        /* new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('SCAN'),
        ),*/
        new FlatButton(
          onPressed: () {
            if (height.text == "" || height.text == null ) {
              AppData.showInSnackBar(context, "Please enter height");

            } else if (double.tryParse(height.text)>250) {
              AppData.showInSnackBar(context, "Please enter valid height");

            }else if (weight.text == "" || weight.text == null) {
              AppData.showInSnackBar(context, "Please enter weight");

            } else if (double.tryParse(weight.text)>636) {
              AppData.showInSnackBar(context, "Please enter valid weight");

            // } else if (TestAppointmentPage.relationmodel == null ||
            //     TestAppointmentPage.relationmodel == "") {
            //   AppData.showInSnackBar(context, "Please select PHC/center ");
            }else {
              String mapping = Aes.encrypt(body.regNo.trim()) +
                  "," +
                  body.age.toString().trim() +
                  "," +
                  body.gender +
                  "," +
                  Aes.encrypt(body.patientName);

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
        //textInputAction: TextInputAction.next,

        /*inputFormatters: [
          //UpperCaseTextFormatter(),
        ],*/
        maxLength: 6,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[0-9. ]")),
        ],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          counterText: "",
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
