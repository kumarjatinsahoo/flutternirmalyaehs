import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/GooglePlacesModel.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart' as session;

class GenericMedicine extends StatefulWidget {
  MainModel model;

  GenericMedicine({Key key, this.model}) : super(key: key);

  @override
  _GenericMedicineState createState() => _GenericMedicineState();
}

class _GenericMedicineState extends State<GenericMedicine> {
  var selectedMinValue;
  GooglePlaceModel googlePlaceModel;
  bool isDataNotAvail = false;
  final ScrollController _scrollController = ScrollController();

  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  Position position;
  String medicallserviceType;

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    medicallserviceType = widget.model.medicineStore;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_QUERY_API1 + medicallserviceType,
        fun: (Map<String, dynamic> map) {
          setState(() {
            googlePlaceModel = GooglePlaceModel.fromJson(map);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return Scaffold(
      appBar: AppBar(
    backgroundColor: AppData.kPrimaryColor,
    title: Text("Generic Stores"),
    centerTitle: true,
      ),
      body: Container(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            (googlePlaceModel != null)
                ? ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: (context, i) {
                      Results patient = googlePlaceModel.results[i];
                      return InkWell(
                        onTap: (){
                          widget.model.placeId = patient.placeId;
                          Navigator.pushNamed(context, "/googleSearch");
                        },
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 5,
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Container(
                                  decoration: (i % 2 == 0)
                                      ? BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:
                                                      AppData.kPrimaryRedColor,
                                                  width: 5)))
                                      : BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ((patient.photos != null &&
                                                patient.photos.isNotEmpty))
                                            ? Material(
                                                elevation: 5.0,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  radius: 40.0,
                                                  backgroundImage: NetworkImage(
                                                      (ApiFactory.GOOGLE_PIC(
                                                          ref: patient.photos[0]
                                                              .photoReference))),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 85,
                                                child: Image.network(
                                                  patient.icon,
                                                ),
                                              ),
                                        /* Image.asset(
                                        "assets/medicine_reminder.png",
                                        height: 40,
                                      ),*/
                                        SizedBox(
                                          width: spaceTab,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  patient.name ?? "N/A",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      /* "No 43,CF Block,Sector III,Bidhannagar\n"
                                                        "Kolkata,West Bengal 700091,India",*/
                                                      patient.formattedAddress,
                                                      style:
                                                          TextStyle(fontSize: 13),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        //Image.asset("assets/Forwordarrow.png",height: 25,)
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: googlePlaceModel.results.length,
                  )
                : Container(),
          ],
        ),
      ),
    ),
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }
}
