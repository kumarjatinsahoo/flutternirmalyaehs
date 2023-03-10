import 'dart:async';
import 'dart:convert' show base64;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/models/DoctoreModel.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/TimeScheduleModel.dart';
import 'package:user/providers/ConnectionStatusSingleton.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm3.dart';
import 'package:user/widgets/Buttons.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import 'package:user/widgets/text_field_address.dart';
//import 'package:matrujyoti/models/LoginResponse.dart';

import '../../../../models/KeyvalueModel.dart';
import '../../../../providers/app_data.dart';

class BookBloodBankPage extends StatefulWidget {
  MainModel model;

  BookBloodBankPage({Key key, this.model}) : super(key: key);

  static KeyvalueModel bloodbankModel = null;
  static KeyvalueModel bloodgroupmodel = null;
  static KeyvalueModel distrModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel specialistModel = null;
  static KeyvalueModel doctorModel = null;
  static KeyvalueModel hospitalModel = null;
  static KeyvalueModel timeModel = null;

  static KeyvalueModel selectDistrict = null;

  @override
  BookBloodBankPageState createState() => BookBloodBankPageState();
}

class BookBloodBankPageState extends State<BookBloodBankPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  String comeFrom;

  DateTime selectedDate = DateTime.now();
  String selectedDatestr;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  TextEditingController appointmentdate = TextEditingController();
  TextEditingController validitytime = TextEditingController();
  TextEditingController expdt = TextEditingController();
  TextEditingController fromPlace = TextEditingController();
  TextEditingController toPlace = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  FocusNode firstname_ = new FocusNode();
  FocusNode middelname_ = new FocusNode();
  FocusNode lastname_ = new FocusNode();
  FocusNode age_ = new FocusNode();
  FocusNode postal_ = new FocusNode();
  FocusNode address_ = new FocusNode();
  FocusNode email_ = new FocusNode();
  FocusNode attendantname_ = new FocusNode();

  List<bool> dropdownError = [false, false, false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  SharedPref sharedPref = SharedPref();
  File _imageCertificate;
  bool selectGallery = false;

  /* List<String> sex = ['Male', "Female", "Other"];
  String selectedSex = "";*/
  List<String> maritalStatus = ["Married", "Single"];
  String selectedMaritalStatus = "";
  List<Map<String, dynamic>> ageProof = [
    {"name": "Voter Id", "id": "1"},
    {"name": "Aadhar Card", "id": "2"}
  ];

  String selectedAgeProof = "";

  var image;
  var pngBytes;

  FocusNode state_ = new FocusNode();
  FocusNode distrct_ = new FocusNode();
  FocusNode block_ = new FocusNode();
  FocusNode panchayat_ = new FocusNode();

  final df = new DateFormat('dd/MM/yyyy');
  final df1 = new DateFormat('dd-MMM-yyyy');
  bool aph = false;
  bool eclampsia = false;
  bool bldpressure = false;
  bool anemia = false;
  String opdId;
  String fromlatitudes;
  String toatitudes;
  String fromllongitudes;
  String tolongitudes;

  Future<Null> _selectDate(
    BuildContext context,
  ) async {
   // MyWidgets.showLoading(context);
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      /*selectedDatestr = df.format(selectedDate).toString();*/
      appointmentdate.text = df.format(picked);
      formattedDate = df1.format(picked);
      selectedDatestr = appointmentdate.text.toString();
    });
  }

  bool isLoginLoading = false;
  int myVerCode;
  bool banner = false;
  KeyvalueModel selectSector;
  static KeyvalueModel selectconsultationtime;
  List<KeyvalueModel> consultationtime = [
    KeyvalueModel(key: "0", name: "10AM-1PM"),
    KeyvalueModel(key: "0", name: "2PM-5PM "),
    KeyvalueModel(key: "0", name: "5PM-8PM "),
    KeyvalueModel(key: "0", name: "8PM-10PM "),
  ];
  TimeOfDay selectedTime = TimeOfDay.now();

  String time;

  bool isActive = true;

  StreamSubscription _connectionChangeStream;
  bool isOffline = true;
  String detailDoc = "";
  bool isOnline = false;

  String formattime;
  bool isValidtime=false;
  String formattedDate;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  @override
  void initState() {
    super.initState();
    comeFrom = widget.model.apntUserType;
    BookBloodBankPage.bloodbankModel = null;
    BookBloodBankPage.bloodgroupmodel = null;
    BookBloodBankPage.doctorModel = null;
    BookBloodBankPage.cityModel = null;
    BookBloodBankPage.distrModel = null;
    BookBloodBankPage.specialistModel = null;
    BookBloodBankPage.hospitalModel = null;
    BookBloodBankPage.timeModel = null;
    // loginResponse = widget.model.loginResponse1;
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOffline = !connectionStatus.hasConnection;
      if (!connectionStatus.hasConnection) {
        color = Colors.green;
      }
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  List<int> _availableHours = [1, 4, 6, 8, 12];

  Future<Null> _selectTime(BuildContext context, bool isIn) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null)
      setState(() {
        formattime = picked.hour.toString() + ":" + picked.minute.toString();
        selectedTime = picked;
        time = formatTimeOfDay(picked);
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n selecteed time$time");
        setState(() {

        });
      });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(MyLocalizations.of(context).text("BLOOD_BANK"),
          style: TextStyle(color: Colors.white),
        ),
        //automaticallyImplyLeading: false,
        toolbarHeight: 60,
        titleSpacing: 5,
        backgroundColor: AppData.matruColor,
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          child: Stack(
            children: [
              ListView(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //addAutomaticKeepAlives: false,
                padding: EdgeInsets.all(5),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  /*Align(
                    child: Text(
                      "Personal details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26.0,
                          color: Colors.black),
                    ),
                    alignment: Alignment.center,
                  ),*/

                  Form(
                    key: _formKey,
                    autovalidate: _autovalidate,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: SizedBox(
                            height: 58,
                            child: DropDown.networkDropdownGetpartUser4(
                                MyLocalizations.of(context).text("BLOODBANK_NAME"),
                                ApiFactory.BLOODBBANKNAME_API,
                                "bloodBankName",
                                 (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.BLOODBBANKNAME_API);
                                BookBloodBankPage.bloodbankModel = data;

                              });
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: SizedBox(
                            height: 58,
                            child: DropDown.networkDropdownGetpartUser4(
                                MyLocalizations.of(context).text("BLOODGROUP"),
                                ApiFactory.BLOODGROUP_API,
                                "bloodgroupBooh",
                                 (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.BLOODGROUP_API);
                                BookBloodBankPage.bloodgroupmodel = data;

                              });
                            }),
                          ),
                        ),
                       /* SizedBox(
                          height: 8,
                        ),*/
                        /*Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            height: 58,
                            child:  DropDown.networkDropdownlabler1(
                            "Blood Group",
                            ApiFactory.BLOODGROUP_API,
                            "bloodgroupBooh", (KeyvalueModel model) {
                          setState(() {
                            BookBloodBankPage.bloodgroupmodel = model;

                            // updateProfileModel.bloodGroup = model.key;
                          });
                        }),
                          )),*/

                        SizedBox(
                          height: 8,
                        ),
                        appointdate(),

                        //comultationTime(),
                        fromAddress(
                            1,
                            MyLocalizations.of(context).text("REASON_FOR_BLOODBANK"),
                            TextInputAction.next,
                            TextInputType.text,
                            address_,
                            email_,
                            "reasonforchoiceofDr"),
                        SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          height: 8,
                        ),
                        //exptdeliveryDt(),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:
                              nextButton(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              isLoginLoading
                  ? Stack(
                      children: [
                        new Opacity(
                          opacity: 0.1,
                          child: const ModalBarrier(
                              dismissible: false, color: Colors.grey),
                        ),
                        new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
  locationData(placeId) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_SEARCH(
            place_id: placeId /*"ChIJ9UsgSdYJGToRiGHjtrS-JNc"*/),
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          Navigator.pop(context);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.RESULT_OK) {
              setState(() {
                GooglePlacesSearchModel googlePlacesSearch =
                GooglePlacesSearchModel.fromJson(map);
                log("Print Select Value>>>>" +
                    googlePlacesSearch.result.geometry.location.lat.toString() +
                    "<<<<" +
                    googlePlacesSearch.result.geometry.location.lng.toString());
                fromlatitudes =
                    googlePlacesSearch.result.geometry.location.lat.toString();
                fromllongitudes=
                    googlePlacesSearch.result.geometry.location.lng.toString();
              });
            } else {
              //isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }

            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }
  locationData1(placeId) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_SEARCH(
            place_id: placeId /*"ChIJ9UsgSdYJGToRiGHjtrS-JNc"*/),
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          Navigator.pop(context);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.RESULT_OK) {
              setState(() {
                GooglePlacesSearchModel googlePlacesSearch =
                GooglePlacesSearchModel.fromJson(map);
                log("Print Select Value>>>>" +
                    googlePlacesSearch.result.geometry.location.lat.toString() +
                    "<<<<" +
                    googlePlacesSearch.result.geometry.location.lng.toString());
                toatitudes =
                    googlePlacesSearch.result.geometry.location.lat.toString();
                tolongitudes=
                    googlePlacesSearch.result.geometry.location.lng.toString();
              });
            } else {
              //isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }

            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }
  Future<List<Predictions>> fetchSearchAutoComplete(String course_name) async {
    var dio = Dio();
    //Map<String, dynamic> postMap = {"course_name": course_name};
    final response = await dio.get(
      ApiFactory.AUTO_COMPLETE + course_name,
    );

    if (response.statusCode == 200) {
      AutoCompleteDTO model = AutoCompleteDTO.fromJson(response.data);
      setState(() {
        //this.courcesDto = model;
      });
      return model.predictions;
    } else {
      setState(() {
        //isAnySearchFail = true;
      });
      throw Exception('Failed to load album');
    }
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SUBMIT"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }


  validate() async {
    _formKey.currentState.validate();
    if (BookBloodBankPage.bloodbankModel == null ||
        BookBloodBankPage.bloodbankModel == "") {
      AppData.showInSnackBar(context, "Please select blood bank name");
    }else if (BookBloodBankPage.bloodgroupmodel == null ||
          BookBloodBankPage.bloodgroupmodel == "") {
        AppData.showInSnackBar(context, "Please select blood group");
      } else if (appointmentdate.text == "" || appointmentdate.text == null) {
      AppData.showInSnackBar(context, "Please select date");

    } else {
      saveDb();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDb() {
    Map<String, dynamic> map = {
      "bloodBankId": BookBloodBankPage.bloodbankModel.key,
      "bloodGrId": BookBloodBankPage.bloodgroupmodel.key,
      "bookedDate":appointmentdate.text.toString(),
      "patientNote": textEditingController[1].text,
      "patientId": widget.model.user,

    };


    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_BlOODBANKDETAILS,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
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
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  otherFormvalidate() {
    showDialog(
        context: _scaffoldKey.currentContext,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            title: Center(child: Text("Preview")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              height: 400,
              // width: 350,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Personal details:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?" *
                          20,
                    ),
                    Text(
                      'Family/Work/Nominee :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Other  Details :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: RaisedButton(
                      child: new Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF121A21),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: RaisedButton(
                        child: new Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color(0xFF121A21),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                ],
              )
            ],
          );
        });
  }

  Widget nextButton1() {
    return GestureDetector(
      onTap: () {
        //personalFormValidate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            "NEXT",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  Widget fromAddress(int index, String hint, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    return TextFieldAddress(
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController[index],
            focusNode: currentfn,
            textInputAction: inputAct,
            inputFormatters: [
              //UpperCaseTextFormatter(),
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
            ],
            keyboardType: keyType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              // suffixIcon: Icon(Icons.person_rounded),
              //contentPadding: EdgeInsets.symmetric(vertical: 10)
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: (newValue) {},
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());
              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, currentfn, nextFn);
            },
          ),
        ],
      ),
    );
  }

  Widget comultationTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTime(context, true);
          // _selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: validitytime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Consultation Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
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

  Widget appointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(
          context,
        ),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: appointmentdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                  MyLocalizations.of(context).text("DATE"),
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget updateButton() {
    return Visibility(
      visible: true,
      child: new InkWell(
        onTap: () {
          // otherFormvalidate();
          //personalFormValidate();
        },
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: new Container(
            //width: 100.0,
            height: 45.0,
            decoration: new BoxDecoration(
              color: AppData.kPrimaryColor,
              //border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius: new BorderRadius.circular(17.0),
            ),
            child: new Center(
              child: new Text(
                'UPDATE',
                style: new TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          //color: Colors.green,
          textColor: Colors.black,
          color: AppData.kPrimaryColor,
          child: Text(
            "UPDATE",
            //style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        RaisedButton(
          textColor: Colors.black,
          color: AppData.kPrimaryColor,
          child: Text(
            "RESET",
          ),
          //color: Colors.grey,
        )
      ],
    );
  }

  TextFormField reuseTextField(String hint, bool error, String comeFrom,
      TextEditingController controller, FocusNode currentFn, FocusNode nextFn) {
    return TextFormField(
      controller: controller,
      //enabled: widget.isConfirmPage ? false : true,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      //textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.text,
      focusNode: currentFn,
      inputFormatters: [
        //UpperCaseTextFormatter(),
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onFieldSubmitted: (value) {
        AppData.fieldFocusChange(context, currentFn, nextFn);
      },
      validator: (value) {
        if (value.isEmpty) {
          error = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          error = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {
        //_addModel.names = value;
        switch (comeFrom) {
          /* case "Village":
            registrationModel.presentStreet1 = value;
            break;
          case "Street":
            registrationModel.presentStreet2 = value;
            break;
          case "pVillage":
            registrationModel.permanentStreet1 = value;
            break;
          case "pStreet":
            registrationModel.permanentStreet2 = value;
            break;*/
        }
      },
    );
  }

  TextFormField disableTextField(String hint, bool error, String comeFrom,
      TextEditingController controller, FocusNode currentFn, FocusNode nextFn) {
    return TextFormField(
      controller: controller,
      enabled: false,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      //textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.text,
      focusNode: currentFn,
      inputFormatters: [
        // UpperCaseTextFormatter(),
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onFieldSubmitted: (value) {
        AppData.fieldFocusChange(context, currentFn, nextFn);
      },
      validator: (value) {
        if (value.isEmpty) {
          error = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          error = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {},
    );
  }

  finalFormSubmit() {
    print("form submit");
  }
}
