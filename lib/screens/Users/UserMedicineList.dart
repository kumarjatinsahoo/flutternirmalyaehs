import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/models/DocterMedicationModel.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/models/MedicineListModel.dart' as medicine;
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

class UserMedicineList extends StatefulWidget {
  MainModel model;
  static KeyvalueModel pharmacyModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

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
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  String userid;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();

  //List<bool> _isChecked=false;
  bool _isChecked = true;
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;

  List<MedicinlistModel> medicinlist = [];

  Map<String, dynamic> mapK = {};

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      callAPI();
      _getLocationName();
    });
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.doctor_MEDICINE_LIST + widget.model.userappointment.appno,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            medicineListModel = MedicineListModel.fromJson(map);
          });
        } else {
          //isDataNotAvail = true;
          AppData.showInSnackBar(context, msg);
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
    callApii(position.latitude.toString(), position.longitude.toString());
  }

  callApii(lat, longi) {
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

            print("HEY>>>>>>>>" + jsonEncode(map));
            print("VLAUEE>>>>>>>>" + address + ">>>>>>>>>" + cityName);
            print("finder2>>>>>>>>>" + finder.addressComponents[4].longName);
            widget.model.pharmacyaddress = address;
            widget.model.pharmacity = finder.addressComponents[4].longName;
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double spaceTab = 20;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                DropDown.networkDropdownGetpartUserrrr(
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
                ),
                (medicineListModel != null)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          if (i == medicineListModel.body.length) {
                            return (medicineListModel.body.length % 10 == 0)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          medicine.Body body = medicineListModel.body[i];
                          widget.model.medicinelist = body;
                          // Print("mediiiicinie"+$body);
                          return Container(
                            child: GestureDetector(
                              // onTap:()=> Navigator.pushNamed(context, "/immunizitaion"),
                              // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist"),
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
                                      CheckboxListTile(
                                        activeColor: Colors.blue[300],
                                        dense: true,
                                        //font change
                                        title: new Text(
                                          medicineListModel.body[i].medname,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5),
                                        ),
                                        value: body.isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            body.isChecked = val;
                                          });
                                        },
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
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (body.morning == "1")
                                                    ? Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors
                                                              .yellow[800],
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
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (body.afternoon == "1")
                                                    ? Container(
                                                        width: 100,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors
                                                              .yellow[800],
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
                                                    "Evening",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (body.evening == "1")
                                                    ? Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors
                                                              .yellow[800],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Duration: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              body.dosage ?? "",
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
                        itemCount: medicineListModel.body.length,
                      )
                    : Container(),
                // ListView.builder(
                //   shrinkWrap: true,
                //   // scrollDirection: Axis.horizontal,
                //   itemCount: medicineListModel.body.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     if (index == medicineListModel.body.length) {
                //       return (medicineListModel.body.length % 10 == 0)
                //           ? CupertinoActivityIndicator()
                //           : Container();
                //     }
                //  body.Body patient = medicineListModel.body[index];
                //
                //     return Padding(
                //       padding:
                //       const EdgeInsets.symmetric(horizontal: 0),
                //           child:Row(
                //               children: [
                //                 Checkbox(
                //                   value: this.valuefirst,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.valuefirst = value;
                //
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   patient.medname,
                //                   style: TextStyle(color: Colors.black,fontSize: 13),
                //                 )
                //               ],
                //             ),
                //     );
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                Material(
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
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

// void itemChange(bool val) {
//   setState(() {
//     _isChecked[index] = val;
//   });
// }
}
