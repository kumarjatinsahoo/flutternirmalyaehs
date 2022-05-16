import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/models/MedicineListModel.dart' as medicine;
import 'package:user/models/MedicineListModel.dart';
import 'package:user/models/PharmacylistModel.dart' as pharmacy;
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

class UserMedicineList extends StatefulWidget {
  MainModel model;
  static KeyvalueModel pharmacyModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  //static pharmacy.PharmacylistModel pharmacylistModel;

  UserMedicineList({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicineList extends State<UserMedicineList> {
  DateTime selectedDate = DateTime.now();
  medicine.MedicineListModel medicineListModel;
  pharmacy.PharmacylistModel pharmacylistModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  String userid;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();

  //List<bool> _isChecked=false;
  LoginResponse1 loginResponse1;
  bool _isChecked = true;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;

  List<MedicinlistModel> medicinlist = [];
  List<medicine.Body> selectedMedicine = [];
  List<pharmacy.Body> selectedpharmacy = [];

  Map<String, dynamic> mapK = {};

  bool isDataNoFound = false;
  bool isdata = true;
  String selectPharma;
  String mode;

  void initState() {
    // TODO: implement initState
    super.initState();
    UserMedicineList.pharmacyModel = null;
    setState(() {
      loginResponse1 = widget.model.loginResponse1;
      _getLocationName();
      callAPI();
    });
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.doctor_MEDICINE_LIST + widget?.model?.appno ?? "",
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            isdata = false;
            medicineListModel = MedicineListModel.fromJson(map);
          });
        } else {
          setState(() {
          isdata = false;  
          });
          
          /* Center(
            child: Text(
              'Data Not Found',
              style: TextStyle(fontSize: 12),
            ),
          );*/
          // AppData.showInSnackBar(context, msg);
        }
      },
    );
  }

  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("dd-MMMM-yyyy").parse(date);
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
    // MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          // Navigator.pop(context);
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
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text(MyLocalizations.of(context).text("MEDICINE_LIST")),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0,top: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/disitalPrescriptionPage");
              },
              child: Text("Prescription"),
            ),
          ),
         /* Padding(
            padding: EdgeInsets.only(right: 18.0,top: 20),
           child:Text("Prescription"),


          ),*/
        ],
        toolbarHeight: (widget.model.apntUserType == Const.HEALTH_CHKUP_APNT)
            ? 0
            : AppBar().preferredSize.height,
      ),
      body: isdata == true
          ? Center(
              child: CircularProgressIndicator(
                  // backgroundColor: AppData.matruColor,
                  ),
            ) /*MyWidgets.showLoading(context)`*/
          // : medicineListModel == null || medicineListModel == null
          //     ? Container(
          //         child: Center(
          //           child: Image.asset("assets/NoRecordFound.png",
          //                                     // height: 25,
          //                                   )
          //         ),
          //       )
              : (medicineListModel != null)
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(""),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pushNamed(context, "/medicineDetailslist");
                                            //displayDialog3(context);

                                          });
                                        },

                                        child:Text("View Order History",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,color: AppData.kPrimaryColor
                                            )
                                        )

                                    ),
                                  ],
                                ),
                              ),

                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {                                 
                                  if (i == medicineListModel.body.length) {
                                    return (medicineListModel.body.length %
                                                10 ==
                                            0)
                                        ? CupertinoActivityIndicator()
                                        : Container();
                                  }
                                  medicine.Body body =
                                      medicineListModel.body[i];
                                  widget.model.medicinelist = body;
                                   print(']]]]]]]]]]]]]]]]]] ' + body.reqstatus.toString());
                                  // Print("mediiiicinie"+$body);
                                  return Container(
                                    child: GestureDetector(
                                      // onTap:()=> Navigator.pushNamed(context, "/immunizitaion"),
                                      // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist"),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (!body.reqstatus)
                                                  ? CheckboxListTile(
                                                      activeColor:
                                                          Colors.blue[300],
                                                      dense: true,
                                                      //font change
                                                      title: new Text(
                                                        medicineListModel
                                                                .body[i]
                                                                .medname ??
                                                            "N/A",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.5),
                                                      ),
                                                      value: body.isChecked,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          body.isChecked = val;
                                                          if (val)
                                                            selectedMedicine
                                                                .add(body);
                                                          else
                                                            selectedMedicine
                                                                .remove(body);
                                                        });
                                                      },
                                                    )
                                                  : /*Container(),*/ Padding(
                                                    padding: const EdgeInsets.all(14.0),
                                                    child: Text(
                                                        medicineListModel.body[i]
                                                                .medname ??
                                                            "N/A",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.5),
                                                      ),
                                                  ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "Morning",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                        (body.morning == "1")
                                                            ? Container(
                                                                width: 80,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 80,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .highlight_remove,
                                                                  color: Colors
                                                                          .yellow[
                                                                      800],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          //width: 80,
                                                          child: Text(
                                                            "Afternoon",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                        (body.afternoon == "1")
                                                            ? Container(
                                                                width: 100,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 80,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .highlight_remove,
                                                                  color: Colors
                                                                          .yellow[
                                                                      800],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "Night",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                        (body.evening == "1")
                                                            ? Container(
                                                                width: 80,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 80,
                                                                height: 30,
                                                                child: Icon(
                                                                  Icons
                                                                      .highlight_remove,
                                                                  color: Colors
                                                                          .yellow[
                                                                      800],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Duration: ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        body.dosage ?? "",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Remark: ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        body.remarks ?? "N/A",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /*Padding(
                                        padding: const EdgeInsets.symmetric( horizontal: 15 ),
                                        child: Text(
                                          */ /*'Confirmed'*/ /*
                                          "Previous",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontSize: 15,
                                              color: AppData.kPrimaryColor
                                          ),
                                        ),
                                      ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: medicineListModel.body.length,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (selectedMedicine != null &&
                                      selectedMedicine.length > 0)
                                  ? Visibility(
                                    visible: _isChecked,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: nextButton(),
                                      ),
                                  )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child:
                      //  (isDataNoFound)?
                           Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                         ,
                    ),
    ));
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        dialogaddnomination(context);
        /*showDialog(
          context: context,
          builder: (BuildContext context) => `dialogaddnomination`(context),
        );*/
        //AppData.showInSnackBar(context, "Please select Title");
        //validate();
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
            // MyLocalizations.of(context).text("SIGN_BTN"),
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  /* Widget dialogaddnomination(BuildContext context) {
    DoctorMedicationlistModel item = DoctorMedicationlistModel();
    textEditingController[0].text = "";
*/
  //Nomine
  dialogaddnomination(BuildContext context) {
    //_date.text = "";
    // = "";
    //_reason.text = "";
    showDialog(
        builder: (context) {
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
                                UserMedicineList.pharmacyModel = data;
                              });
                            }, mapK),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          MyLocalizations.of(context).text("OR"),
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        NumberformField(0, "Enter Pharmacy"),
                        fromAddress(1, "Remark", TextInputAction.next,
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
                textColor: AppData.kPrimaryRedColor,
                child: Text(
                  MyLocalizations.of(context).text("CANCEL"),
                ),
              ),
              new FlatButton(
                child: Text(
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  if ((UserMedicineList.pharmacyModel == null ||
                          UserMedicineList.pharmacyModel == "") &&
                      (textEditingController[0].text == "" ||
                          textEditingController[0].text == null)) {
                    AppData.showInSnackBar(context, "Please select Pharmacy ");
                  }
                  /*if (UserMedicineList.pharmacyModel == null ||
                UserMedicineList.pharmacyModel == "") {
              AppData.showInSnackBar(context, "Please select Pharmacy ");
            }*/
                  else {
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
                          setState(() {
                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              //Navigator.pop(context);
                              callAPI();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              AppData.showInSnackBar(
                                  context, map[Const.MESSAGE]);
                            }
                            _isChecked=false;
                          });
                        });
                  }
                  Navigator.of(context).pop();
                  textEditingController[0].text = "";
                },
              ),
            ],
          );
        },
        context: context);
  }

  Map<String, dynamic> fromJsonListData(List list) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = loginResponse1.body.user;
    data['pharmacistid'] = (UserMedicineList.pharmacyModel != null)
        ? UserMedicineList.pharmacyModel.key : selectPharma;
    data['patientnote'] = textEditingController[1].text;
    data['meddetails'] = this.selectedMedicine.map((v) => v.toJson1()).toList();
    return data;
  }

  Widget fromAddress(int index, String hint, inputAct, keyType, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        //focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
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

  Widget dialogRegNo(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 30),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //_buildAboutText(),
                  //_buildLogoAttribution(),
                  Text(
                    "SEARCH",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                      elevation: 5,
                      child: Container(
                        width: double.maxFinite,
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            style: TextStyle(color: Colors.black),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(
                                  fontFamily: "Monte",
                                  fontSize: 17,
                                  color: Colors.black54),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                            ),
                            onSubmitted: (String value) {
                              if (value != "") {
                                /*widget.model.searchFilter = value;
                                    Navigator.pushNamed(context, "/searchResult");*/
                                //fetchSearchResult(value);
                              }
                              //AppData.showInSnackDone(context, value);
                            },
                          ),
                          getImmediateSuggestions: true,
                          suggestionsCallback: (pattern) async {
                            return (pattern != null)
                                ? await fetchSearchAutoComplete(pattern)
                                : null;
                          },
                          hideOnLoading: true,
                          itemBuilder: (context, pharmacy.Body suggestion) {
                            return ListTile(
                              leading: Icon(Icons.search),
                              title: Text(suggestion.name),
                            );
                          },
                          onSuggestionSelected: (pharmacy.Body suggestion) {
                            //widget.model.courceName = suggestion.courseSlug;
                            //Navigator.pushNamed(context, "/courceDetail1");
                            Navigator.pop(context);

                            setState(() {
                              textEditingController[0].text =
                                  "${suggestion.name}";
                              selectPharma = suggestion.key;

                              cityName = (suggestion?.name != null &&
                                      suggestion?.name?.length >= 3)
                                  ? suggestion.name[suggestion.name.length - 3]
                                  : "";
                              //print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
                              // longitudes = suggestion.longitude.toString();
                              // latitudes = position.altitude.toString();
                              // locationData(suggestion.placeId);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      /*actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("Cancel"),
        ),
        new FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],*/
    );
  }

  Future<List<pharmacy.Body>> fetchSearchAutoComplete(
      String course_name) async {
    var dio = Dio();
    //Map<String, dynamic> postMap = {"course_name": course_name};
    final response = await dio.get(
      ApiFactory.pharmacy_list_by_searchvalue + course_name,
    );

    if (response.statusCode == 200) {
      pharmacylistModel = pharmacy.PharmacylistModel.fromJson(response.data);
      setState(() {
        //this.courcesDto = model;
      });
      return pharmacylistModel.body;
    } else {
      setState(() {
        //isAnySearchFail = true;
      });
      throw Exception('Failed to load album');
    }
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
                latitudes =
                    googlePlacesSearch.result.geometry.location.lat.toString();
                longitudes =
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

  Widget NumberformField(int index, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
          onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => dialogRegNo(context),
              ),
          child: AbsorbPointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: hint,

                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: textEditingController[index],
              ),
            ),
          )),
    );
  }
}
