import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/GooglePlacesModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart' as session;

class GenericMedicineNew extends StatefulWidget {
  MainModel model;
  static KeyvalueModel distancelistModel = null;

  GenericMedicineNew({Key key, this.model}) : super(key: key);

  @override
  _GenericMedicineNewState createState() => _GenericMedicineNewState();
}

class _GenericMedicineNewState extends State<GenericMedicineNew> {

  var selectedMinValue;
  GooglePlaceModel googlePlaceModel;
  bool isDataNotAvail = false;
  ScrollController _scrollController = ScrollController();
  session.LoginResponse1 loginResponse1;
  String longi, lati, city, addr, healthpro, type, speciality;
  String nextpage;
  int currentMax = 1;


  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    longi = widget.model.longi;
    lati = widget.model.lati;
    city = widget.model.city;
    addr = widget.model.addr;
    healthpro = widget.model.healthproname;
    type = widget.model.type;
    speciality ="";
    callAPI(5, currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        callAPIPagination(nextpage);
      }
    });
  }

  List<KeyvalueModel> selectDistance = [
    KeyvalueModel(name: "5 KM", key: 5),
    KeyvalueModel(name: "10 KM", key: 10),
    KeyvalueModel(name: "20 KM", key: 20),
    KeyvalueModel(name: "50 KM", key: 50),
  ];

  callAPI(int radius, int i) {
    log("API :Lati & Longi" + lati + "\n" + longi);
    var pp = healthpro.replaceAll(RegExp(' & +'), ' ');
    healthpro = pp.replaceAll(RegExp(' +'), '|');
    log(ApiFactory.GOOGLE_QUERY_API(
        lati: lati,
        longi: longi,
        radius: (radius * 1000).toString(),
        healthpro: (healthpro != null)
                ? speciality.toLowerCase()  + "|" + healthpro.toLowerCase() + "|" + widget.model.city.toLowerCase()
                : healthpro.toLowerCase() + "|" + widget.model.city.toLowerCase()
            ));
    setState(() {
      isDataNotAvail = false;
      googlePlaceModel=null;
    });
    // googlePlaceModel=null;
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_QUERY_API(
            lati: lati,
            longi: longi,
            radius: (radius * 1000).toString(),
            // healthpro: (speciality != null)
            //     ? healthpro + " " + speciality
            //     : healthpro
            healthpro: (speciality != null)
                ? speciality.toLowerCase()  + "|" + healthpro.toLowerCase() + "|" + widget.model.city.toLowerCase()
                : healthpro.toLowerCase() + "|" + widget.model.city.toLowerCase()
                ),
        fun: (Map<String, dynamic> map) {
          setState(() {
            // String msg = map[Const.MESSAGE];
            if (map["status"] == "OK") {
              // if (i == 1) {
              googlePlaceModel = GooglePlaceModel.fromJson(map);
              nextpage = googlePlaceModel.nextPageToken;
              print('================ Narmada ' +
                  googlePlaceModel.results[0].geometry.location.lat.toString() +
                  ',' +
                  googlePlaceModel.results[0].geometry.location.lng.toString());
              var str1 =
                  googlePlaceModel.results[0].geometry.location.lat.toString();
              var str2 =
                  googlePlaceModel.results[0].geometry.location.lng.toString();
              var latiStr = lati.split(".").first;
              var longiStr = longi.split(".").first;
              var gglLatLongi = latiStr + ',' + longiStr;
              print('Narmada1 ' + gglLatLongi);

              var lat = str1.split(".").first;
              var lng = str2.split(".").first;
              var latLng = lat + ',' + lng;
              print('Narmada2 ' + latLng);
              /* if (gglLatLongi == latLng) {
                isDataNotAvail = true;
                print('true ');
              } else {
                isDataNotAvail = false;
                googlePlaceModel = null;
                print('false ');
              }*/
              // } else {
              //   googlePlaceModel.addMore(map);
              // }
            } else {
              //   isDataNotAvail = true;
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }
          });
        });
  }

  callAPIPagination(nxtpagetoken) {
    log("API :Lati & Longi" + lati + "\n" + lati);
    log("API CALL>>Narmada>" +
        ApiFactory.GOOGLE_PAGINATION_API(pagetoken: nxtpagetoken + "\n\n\n"));
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_PAGINATION_API(pagetoken: nxtpagetoken),
        fun: (Map<String, dynamic> map) {
          setState(() {
            //String msg = map[Const.MESSAGE];
            //if (map["status"] == "ok") {
            //         if (i == 1) {
            //  googlePlaceModel = GooglePlaceModel.fromJson(map);
            //         }
            //         else{
            googlePlaceModel.addMore(map);
            nextpage = map["next_page_token"] ?? null;
            // googlePlaceModel.nextPageToken=map["next_page_token"];
            // }
            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
    backgroundColor: AppData.kPrimaryColor,
    title: Text(MyLocalizations.of(context).text("GENERIC_STORE")),
    centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //         child: Text(
              //       'Select Distance',
              //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              //     )),
              //     Expanded(
              //       child: DropDown.networkDrop("5 KM", "5 KM", selectDistance,
              //           (KeyvalueModel data) {
              //         setState(() {
              //           GenericMedicineNew.distancelistModel = data;
              //           callAPI(data.key, currentMax);
              //         });
              //       }),
              //     ),
              //   ],
              // ),
              (googlePlaceModel != null &&
                      googlePlaceModel.results != null &&
                      googlePlaceModel.results.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, i) {
                          if (i == googlePlaceModel.results.length) {
                            return (googlePlaceModel.results.length % 20 == 0 &&
                                    googlePlaceModel.nextPageToken != null)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          Results patient = googlePlaceModel.results[i];
                          return Container(
                              child: InkWell(
                            onTap: () {
                              //widget.model.model = patient.placeId;
                              widget.model.placeId = patient.placeId;
                              Navigator.pushNamed(context, "/googleSearch");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 5,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                    decoration: (i % 2 == 0)
                                        ? BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData
                                                        .kPrimaryRedColor,
                                                    width: 5)))
                                        : BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryColor,
                                                    width: 5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
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
                                                            ref: patient
                                                                .photos[0]
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    patient.name ?? "N/A",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        /* "No 43,CF Block,Sector III,Bidhannagar\n"
                                                      "Kolkata,West Bengal 700091,India",*/
                                                        patient
                                                            .formattedAddress,
                                                        style: TextStyle(
                                                            fontSize: 13),
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
                          ));
                        },
                        itemCount: googlePlaceModel.results.length + 1,
                      ),
                    )
                  : Container(
                      height: size.height * 0.6,
                      child: Center(
                          child: isDataNotAvail
                              ? Image.asset("assets/NoRecordFound.png")
                              : CircularProgressIndicator()),
                    )

              // :  Expanded(
              //   child: Container(
              //           child: Center(
              //             child:  CircularProgressIndicator(
              //     backgroundColor: AppData.matruColor,
              //             )
              //           ),
              //         ),
              // )
            ],
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
