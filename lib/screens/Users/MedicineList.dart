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
import 'package:user/models/AppointmentlistModel.dart' as apnt;
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';
import 'package:user/widgets/text_field_container.dart';

class MedicineList extends StatefulWidget {
  MainModel model;
  static KeyvalueModel pharmacyModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  MedicineList({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicineList extends State<MedicineList> {
  DateTime selectedDate = DateTime.now();
  medicine.MedicineListModel medicineListModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  String userid;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  bool valuefirst = false;

  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;

  List<MedicinlistModel> medicinlist = [];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Nirmalya pharmacy", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];

  Map<String, dynamic> mapK={};

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
            //AppData.showInSnackBar(context, msg);
            medicineListModel = MedicineListModel.fromJson(map);
          });

          //foundUser = appointModel.body;
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

            print("HEY>>>>>>>>"+jsonEncode(map));
            print("VLAUEE>>>>>>>>"+address+">>>>>>>>>"+cityName);
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                DropDown.networkDropdownGetpartUserundrelinee(
                    "Choose Pharmacy",
                    ApiFactory.PHARMACY_LIST ,
                    "choosepharmacy", (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.GENDER_API);
                    MedicineList.pharmacyModel = data;
                  });
                }, mapK),
                SizedBox(
                  height: 10,
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
                              // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist"),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: this.valuefirst,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.valuefirst = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        body.medname,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                      )
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
}
