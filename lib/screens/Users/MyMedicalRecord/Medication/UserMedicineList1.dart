import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicalPrescriptionModel.dart' as medicine;
import 'package:user/models/MedicalPrescriptionModel.dart';
import 'package:user/models/MedicinModel.dart';
/*import 'package:user/models/MedicineListModel.dart' as medicine;*/
import 'package:user/models/MedicineListModel.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';

class UserMedicineList1 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel pharmacyModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  UserMedicineList1({Key key, this.model, this.isConfirmPage})
      : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicineList extends State<UserMedicineList1> {
  DateTime selectedDate = DateTime.now();
  //medicine.MedicalPrescriptionModel medicineListModel;
  medicine.MedicalPrescriptionModel medicineListModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  String userid;
  var df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();

  LoginResponse1 loginResponse1;
  bool _isChecked = true;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  bool isDataNoFound = false;
  bool DataFound = true;
  List<MedicinlistModel> medicinlist = [];
  List<medicine.Body> selectedMedicine = [];

  Map<String, dynamic> mapK = {};
  String mode;
  bool isdata = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    UserMedicineList1.pharmacyModel = null;
    //_getLocationName();
    callAPI();
  }

  callAPI() {
    log("Api call>>"+ApiFactory.MEDICAL_PRESCRIPTION + loginResponse1.body.user);
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.MEDICAL_PRESCRIPTION +loginResponse1.body.user,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            medicineListModel = MedicalPrescriptionModel.fromJson(map);
            print("location>>>>>>>>>>>>>>>>>>"+medicineListModel.body[0].meddate);
            isdata=false;
          });
        } else {
          setState(() {
            isDataNoFound = true;
            isdata=false;
          });
          //isDataNotAvail = true;
          //AppData.showInSnackBar(context, msg);
        }
      },
    );
  }
  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("d-MMM-yyyy").parse(date);
     // final DateTime formatter =
      //DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ\'").parse(date);
      //DateFormat("dd/MM/yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd-MM-yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }
  static String toDate1(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("d-MMM-yyyy").parse(date);
     // final DateTime formatter =
      //DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ\'").parse(date);
      //DateFormat("dd/MM/yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd-MM-yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }
  _getLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print(
        'location>>>>>>>>>>>>>>>>>>: ${position.latitude},${position.longitude}');
    geocodeFetch(position.latitude.toString(), position.longitude.toString());
  }

  geocodeFetch(lat, longi) {
    print(">>>>>>>>>" + ApiFactory.GOOGLE_LOC(lat: lat, long: longi));
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          ResultsServer finder = ResultsServer.fromJson(map["results"][0]);
          print("finder1>>>>>>>>>" + finder.toJson().toString());

          setState(() {
            address = "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            mapK["address"] = address;
            mapK["city"] = cityName;
            widget.model.pharmacyaddress = address;
            widget.model.pharmacity = finder.addressComponents[4].longName;
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
            print("location>>>>>>>>>>>>>>>>>>"+medicineListModel.body[0].meddate);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("aasd")),
      body: isdata == true
              ? Center(
            child: CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            ),
          ):
      (medicineListModel != null)
        ?Container(
    child: SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              (medicineListModel != null)
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // controller: _scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                       /* if (i == medicineListModel.body.length) {
                          return (medicineListModel.body.length % 10 == 0)
                              ? CupertinoActivityIndicator()
                              : Container();
                        }*/
                        medicine.Body body = medicineListModel.body[i];

                       // widget.model.medicinelist = ;
                        if(mode==null){
                          mode=body.status;
                        }
                        return InkWell(
                          onTap: (){
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            widget.model.appno=body?.appno ;
                            widget.model.meddatest=body?.meddate;
                            widget.model.doctorst=body?.doctor;
                              Navigator.pushNamed(
                                  context,
                                  "/userMedicineList");
                          //  Navigator.pushNamed(context, "/medicinelisturl");
                          },
                          child: Container(
                            child: GestureDetector(
                              // onTap:()=> Navigator.pushNamed(context, "/immunizitaion"),
                              // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist")
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                elevation: 3,
                                child: ClipPath(
                                clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5))),
                                child: Container(
                                  decoration: (i % 2 == 0)
                                      ? BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: AppData
                                                  .kPrimaryRedColor,
                                              width: 4)))
                                      : BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color:
                                              AppData.kPrimaryColor,
                                              width: 4))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                     Text(body?.drName ??
                                                    "N/A",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.5),
                                              ),
                                        SizedBox(
                                          width: 5,
                                        ),

                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .end,
                                          children: [
                                            Text(MyLocalizations.of(context).text("PRESCRIPTION_DATE"),
                                              style: TextStyle(
                                                  fontSize: 14,color: Colors
                                                  .grey),
                                            ),
                                            Spacer(),
                                            Text(

                                              body.meddate??"N/A",
                                              //   body.meddate??"N/A",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors
                                                      .grey),
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .end,
                                          children: [
                                            Text(MyLocalizations.of(context).text("DOSAGE"),
                                              style: TextStyle(
                                                  fontSize: 14,color: Colors
                                                  .grey),
                                            ),
                                            Spacer(),
                                            Text(
                                              /*'Confirmed'*/
                                              body.status ??
                                                  "N/A",
                                              style: TextStyle(

                                                  fontSize: 14,
                                                  color: Colors
                                                      .grey),
                                            ),
                                          ],
                                        ),
                                        /*SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.blue
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              child: Text("SET REMINDER",style: TextStyle(color: Colors.white),),
                                            )
                                          ],
                                        )*/
                                      ],
                                    ),
                                  ),
                                ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: medicineListModel.body.length,
                    )
                  : Container(),



            ],
          ),
        ),
      ),
    ),
      ): Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    alignment: Alignment.center,
    child: (isDataNoFound) ? 
    Center(
      child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            ),
    ):
    callAPI(),


      ),
    );
  }

  Widget nextButton() {
    return GestureDetector(
     /* onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => dialogaddnomination(context),
        )},*/
        //AppData.showInSnackBar(context, "Please select Title");
        //validate();

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
            // MyLocalizations.of(context).text("SIGN_BTN"),
            "SUBMIT",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

 /* Widget dialogaddnomination(BuildContext context) {
    DoctorMedicationlistModel item = DoctorMedicationlistModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.86,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //_buildAboutText(),
                  //_buildLogoAttribution(),
                  Text(
                    "Assign to Pharmacy",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: SizedBox(
                      height: 58,
                      child: DropDown.networkDropdownGetpartUserrrr(
                          "Choose Pharmacy",
                          ApiFactory.PHARMACY_LIST,
                          "choosepharmacy", (KeyvalueModel data) {
                        setState(() {
                          UserMedicineList1.pharmacyModel = data;
                        });
                      }, mapK),
                    ),
                  ),

                  fromAddress(0, "Remark", TextInputAction.next,
                      TextInputType.text, "remark"),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            if (UserMedicineList1.pharmacyModel == null ||
                UserMedicineList1.pharmacyModel == "") {
              AppData.showInSnackBar(context, "Please select Pharmacy ");
            } else {
              // Navigator.of(context).pop();
              *//*String userid = loginResponse1.body.user;
              String pharmacistid = UserMedicineList.pharmacyModel.key;
              String patientnote = textEditingController[0].text.toString();*//*
              Map<String, dynamic> map = fromJsonListData(selectedMedicine);

              log("API NAME>>>>" + ApiFactory.POST_PHARMACY_REQUST);
              log("TO POST>>>>" + jsonEncode(map));
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.POST_PHARMACY_REQUST,
                  json: map,
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                      callAPI();
                      //popup(context, "Medicine Added Successfully",map[Const.BODY]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
            }
            Navigator.of(context).pop();
            textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Save'),
        ),
      ],
    );
  }*/


  Widget fromAddress(int index, String hint, inputAct, keyType, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        //focusNode: currentfn,
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
          /* print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });*/

          /// AppData.fieldFocusChange(context, currentfn, nextFn);
        },
      ),
    );
  }

// void itemChange(bool val) {
//   setState(() {
//     _isChecked[index] = val;
//   });
// }
}
