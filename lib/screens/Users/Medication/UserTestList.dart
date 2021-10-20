import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicineListModel.dart' as medicine;
import 'package:user/models/ResultsServer.dart';
import 'package:user/models/UserListModel.dart' as test;
import 'package:user/models/UserListModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';

class UserTestList extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel selectedLab = null;
  UserTestList({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicineList extends State<UserTestList> {
  DateTime selectedDate = DateTime.now();
  test.UserListModel userListModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  String userid;
  bool isdata =false;

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
bool isdata = false;
  List<UserListModel> testlist = [];
  List<test.Body> selectedTest = [];

  Map<String, dynamic> mapK = {};

  void initState() {
    // TODO: implement initState
    super.initState();
    UserTestList.labModel = null;
    setState(() {
      loginResponse1 = widget.model.loginResponse1;
      _getLocationName();
      callAPI();
    });
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.doctor_TEST_LIST + widget.model.userappointment.appno,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            userListModel = UserListModel.fromJson(map);
          });
        } else {
          //isDataNotAvail = true;
          AppData.showInSnackBar(context, msg);
        }
      },
    );
  }

  addLabRequest() {
    widget.model.POSTMETHOD_TOKEN(
      api: ApiFactory.LAB_REQUEST,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            userListModel = UserListModel.fromJson(map);
          });
        } else {
          //isDataNotAvail = true;
          //AppData.showInSnackBar(context, msg);
        }
      },
    );
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
            //mapK["city"] = "bhubaneswar";

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
      body:
      isdata == true
          ? CircularProgressIndicator(
        backgroundColor: AppData.matruColor,
      )
          : userListModel == null || userListModel == null
          ? Container(
        child: Center(
          child: Text(
            'No Data Found',
            style:
            TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),

      )
          :SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),

            child: Column(
              children: [

                /* DropDown.networkDropdownGetpartUserrrr(
                    "Choose Pharmacy",
                    ApiFactory.PHARMACY_LIST,
                    "choosepharmacy", (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.GENDER_API);
                    UserMedicineList.pharmacyModel = data;
                  });
                }, mapK),
                SizedBox(
                  height: 15,
                ),*/
                isdata == true
                    ? CircularProgressIndicator(
                  backgroundColor: AppData.matruColor,
                )
                    : userListModel == null || userListModel == null
                    ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Data Found',
                          style:
                          TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                )
                    :
                (userListModel != null)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          if (i == userListModel.body.length) {
                            return (userListModel.body.length % 10 == 0)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          test.Body body = userListModel.body[i];
                          widget.model.testList = body;
                          return Container(
                            child: GestureDetector(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
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
                                              activeColor: Colors.blue[300],
                                              dense: true,
                                              //font change
                                              title: new Text(
                                                userListModel
                                                        .body[i].testname ??
                                                    "N/A",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.5),
                                              ),
                                              value: body.isChecked,
                                              onChanged: (val) {
                                                setState(() {
                                                  body.isChecked = val;
                                                  if (val)
                                                    selectedTest.add(body);
                                                  else
                                                    selectedTest.remove(body);
                                                });
                                              },
                                            )
                                          : /*Container(),*/ Text(
                                              userListModel.body[i].testname ??
                                                  "N/A",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Appoint no: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              body.appno ?? "N/A",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Type: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              body.testgroup ?? "N/A",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Remark: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              body.remarks ?? "N/A",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: userListModel.body.length,
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                (selectedTest != null && selectedTest.length > 0)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: nextButton(),
                      )
                    : Container(),
                /*Material(
                  elevation: 5,
                  color: const Color(0xFF0F6CE1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 350,
                    height: 40.0,
                    child: Text(
                      " SUBMIT ",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget dialogAddLab(BuildContext context) {
    DoctorMedicationlistModel item = DoctorMedicationlistModel();
    textEditingController[0].text = "";

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
                    "Assign to Lab",
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
                          "Choose Lab",
                          ApiFactory.LAB_LIST_LOC,
                          "choosepharmacy", (KeyvalueModel data) {
                        setState(() {
                          UserTestList.selectedLab = data;
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
            if (UserTestList.selectedLab == null ||
                UserTestList.selectedLab == "") {
              AppData.showInSnackBar(context, "Please select Lab ");
            } else {
              Map<String, dynamic> map = fromJsonListData(selectedTest);

              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.LAB_REQUEST,
                  json: map,
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {
                      if (map[Const.STATUS1] == Const.SUCCESS) {
                        callAPI();
                        AppData.showInSnackDone(context, map[Const.MESSAGE]);
                      } else {
                        AppData.showInSnackBar(context, map[Const.MESSAGE]);
                      }
                    });
                  });
            }
            // Navigator.of(context).pop();
            // textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Map<String, dynamic> fromJsonListData(List list) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = loginResponse1.body.user;
    data['pharmacistid'] = UserTestList.selectedLab.key;
    data['patientnote'] = textEditingController[0].text;
    data['meddetails'] = this.selectedTest.map((v) => v.toJson1()).toList();
    return data;
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => dialogAddLab(context),
        );
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
            "SUBMIT",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

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
