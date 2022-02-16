import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as loca;

class GenericStores extends StatefulWidget {
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel countryModel = null;

  GenericStores({Key key, this.model}) : super(key: key);

  @override
  _GenericStoresState createState() => _GenericStoresState();
}

class _GenericStoresState extends State<GenericStores> {
  var selectedMinValue;
  String country = "", state = "", district = "", city = "";
  UserRegistrationModel userModel = UserRegistrationModel();
  String longitudes;
  String latitudes;
  String address;
  String cityName;
  Position position;
  TextEditingController searchText =new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GenericStores.countryModel = null;
    GenericStores.stateModel = null;
    GenericStores.districtModel = null;
    GenericStores.cityModel = null;
    _getLocationName();
  }

 _getLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print(
        'location>>>>>>>>>>>>>>>>>>: ${position.latitude},${position.longitude}');
    latitudes = position.latitude.toString();
    longitudes = position.longitude.toString();
    callApi(position.latitude.toString(), position.longitude.toString());
    
  }

 callApi(lat, longi) {
    print("NARMADA>>>>>>>>>" + ApiFactory.GOOGLE_LOC(lat: lat, long: longi));
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          ResultsServer finder = ResultsServer.fromJson(map["results"][0]);
          print("finder------Narmada>>>>>>>>> " + lat.toString() + "," + longi.toString());
          setState(() {
            address = "${finder.formattedAddress}";
           searchText.text= "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            // longitudes = position.longitude.toString();
            // latitudes = position.altitude.toString();
            longitudes = longi.toString();
            latitudes =  lat.toString();    
            });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("GENERIC_MEDICAL_STORE"),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/generictop.png",
                            // width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      MyLocalizations.of(context).text("FIND_GENERIC_STORE"),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Request your doctor to prescribe generic medicine.',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 35),
                    /*DropDown.staticDropdown2('India', "country", countryList,
                (KeyvalueModel data) {
              setState(() {
                GenericStores.stateModel = data;
                GenericStores.stateModel = null;
              });
            }),
            SizedBox(
              height: 25,
            ),

            DropDown.networkDropdownGetpartUserundreline(
                "State",
                ApiFactory.STATE_API +"99",
                    // (GenericStores?.countryModel?.key ?? ""),
                "state", (KeyvalueModel data) {
              setState(() {
                print(ApiFactory.STATE_API);
                GenericStores.stateModel = data;
                GenericStores.districtModel = null;
              });
            }),
            SizedBox(
              height: 25,
            ),
            DropDown.networkDropdownGetpartUserundreline(
                "District", ApiFactory.DISTRICT_API +(GenericStores?.stateModel?.key??""), "district",
                    (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.DISTRICT_API);
                    GenericStores.districtModel = data;
                    GenericStores.cityModel = null;
                  });
                }),
            SizedBox(
              height: 25,
            ),
            DropDown.networkDropdownGetpartUserundreline(
                "Select City", ApiFactory.CITY_API + (GenericStores?.districtModel?.key??""), "city",
                    (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.CITY_API);
                    GenericStores.cityModel = data;
                    // LabSignUpForm3.districtModel = null;
                  });
                }),*/
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 0, right: 0),
                    //   child: SizedBox(
                    //     height: 58,
                    //     child: DropDown.genericMedicine(
                    //         context,
                    //         MyLocalizations.of(context).text("COUNTRY"),
                    //         ApiFactory.COUNTRY_API,
                    //         "country",
                    //         Icons.location_on_rounded,
                    //         23.0, (KeyvalueModel data) {
                    //       setState(() {
                    //         print(ApiFactory.COUNTRY_API);
                    //         GenericStores.countryModel = data;
                    //         GenericStores.stateModel = null;
                    //         GenericStores.districtModel = null;
                    //         GenericStores.cityModel = null;
                    //       });
                    //     }),
                    //   ),
                    // ),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                    //   child: SizedBox(
                    //     height: 58,
                    //     child: DropDown.genericMedicine(
                    //         context,
                    //         MyLocalizations.of(context).text("STATE"),
                    //         ApiFactory.STATE_API +
                    //             (GenericStores?.countryModel?.key ?? ""),
                    //         "state",
                    //         Icons.location_on_rounded,
                    //         23.0, (KeyvalueModel data) {
                    //       setState(() {
                    //         GenericStores.stateModel = data;
                    //         GenericStores.districtModel = null;
                    //         GenericStores.cityModel = null;
                    //       });
                    //     }),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 0, right: 0),
                    //   child: SizedBox(
                    //     height: 58,
                    //     child: DropDown.genericMedicine(
                    //         context,
                    //         MyLocalizations.of(context).text("DIST"),
                    //         ApiFactory.DISTRICT_API +
                    //             (GenericStores?.stateModel?.key ?? ""),
                    //         "district1",
                    //         Icons.location_on_rounded,
                    //         23.0, (KeyvalueModel data) {
                    //       setState(() {
                    //         print(ApiFactory.COUNTRY_API);
                    //         GenericStores.districtModel = data;
                    //         GenericStores.cityModel = null;
                    //       });
                    //     }),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                    //   child: SizedBox(
                    //     height: 58,
                    //     child: DropDown.genericMedicine(
                    //         context,
                    //         MyLocalizations.of(context).text("CITY"),
                    //         ApiFactory.CITY_API +
                    //             (GenericStores?.districtModel?.key ?? ""),
                    //         "city",
                    //         Icons.location_on_rounded,
                    //         23.0, (KeyvalueModel data) {
                    //       setState(() {
                    //         GenericStores.cityModel = data;
                    //         /*userModel.state=data.key;
                    //               userModel.stateCode=data.code;*/
                    //       });
                    //     }),
                    //   ),
                    // ),
                   
                   NumberformField(address),
                    SizedBox(
                      height: 25,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/genericbottom.jpg",
                            // width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        */ /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/ /*

        Navigator.pushNamed(context, "genericstoreslist");
        //}

      },
    );
  }*/

 Widget NumberformField(
    /* int index,*/
    String hint,
  ) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => dialogRegNo(context),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: EdgeInsets.only(left: 5, right: 8, top: 10),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), //shadow direction: bottom right
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(child: Text(hint ?? "",style: TextStyle(color: Colors.black,fontSize: 16),)),
            //Icon(Icons.add_location),
            InkWell(
                child: Icon(
              Icons.search,
              color: Colors.grey,
            )),
          ],
        ),
       
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
                          itemBuilder: (context, Predictions suggestion) {
                            return ListTile(
                              leading: Icon(Icons.search),
                              title: Text(suggestion.description),
                            );
                          },
                          onSuggestionSelected: (Predictions suggestion) {
                            //widget.model.courceName = suggestion.courseSlug;
                            //Navigator.pushNamed(context, "/courceDetail1");
                            Navigator.pop(context);
                            setState(() {
                              address = "${suggestion.description}";
                              searchText.text =
                                  "${suggestion.description}";
                              cityName = (suggestion?.terms != null &&
                                      suggestion?.terms?.length >= 3)
                                  ? suggestion
                                      .terms[suggestion.terms.length - 3].value
                                  : "";
                              //print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
                              // longitudes = suggestion.longitude.toString();
                              // latitudes = position.altitude.toString();
                              locationData(suggestion.placeId);
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
     
    );
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
  
 locationData(placeId) {
   print("NARMADA>>>>>>>>>" + ApiFactory.GOOGLE_SEARCH(place_id: placeId));
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
                GooglePlacesSearchModel googlePlacesSearch = GooglePlacesSearchModel.fromJson(map);
                print("Print Select Value>>>>" +
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


  Widget _submitButton() {
    return MyWidgets.nextButton(
      text:  MyLocalizations.of(context).text("SEARCH").toUpperCase(),
      context: context,
      fun: () {
         if (searchText.text == null ||
            searchText.text == "") {
          AppData.showInSnackBar(context, "Please enter location");
        }
        // if (GenericStores.countryModel == null ||
        //     GenericStores.countryModel == "") {
        //   AppData.showInSnackBar(context, "Please select country");
        // } else if (GenericStores.stateModel == null ||
        //     GenericStores.stateModel == "") {
        //   AppData.showInSnackBar(context, "Please select state");
        // } else if (GenericStores.districtModel == null ||
        //     GenericStores.districtModel == "") {
        //   AppData.showInSnackBar(context, "Please select district");
        // } else if (GenericStores.cityModel == null ||
        //     GenericStores.cityModel == "") {
        //   AppData.showInSnackBar(context, "Please select city");
        // }
         else {
          //country = "99";
          // country = GenericStores.countryModel.name;
          // state = GenericStores.stateModel.name;
          // district = GenericStores.districtModel.name;
          // city = GenericStores?.cityModel?.name ?? "";
          widget.model.medicineStore = "generic medicine store," ;
              // city +
              // "," +
              // district +
              // "," +
              // state +
              // "," +
              // country;
           widget.model.longi = longitudes;
          widget.model.lati = latitudes;
          widget.model.addr = address;
          widget.model.city = cityName;
          widget.model.healthpro = 'generic medicine store';
          widget.model.healthproname = 'Generic medicine store';
          //widget.model.healthproname = "Doctor";

          //Navigator.pushNamed(context, "/navigation");
          /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/
        print('------------ longitudes Narmada ' + latitudes +","+ longitudes);
          Navigator.pushNamed(context, "/genericMedicineNew");
          //Navigator.pushNamed(context, "/searchScreen");
        }
        //   Navigator.pushNamed(context, "/genericMed");
        // }
      },
    );
  }
}
