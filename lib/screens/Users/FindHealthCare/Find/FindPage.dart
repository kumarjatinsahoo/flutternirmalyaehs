import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

import 'package:geolocator/geolocator.dart' as loca;
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

import '../../Dashboard/AboutUs.dart';

class FindPage extends StatefulWidget {
  MainModel model;
  static KeyvalueModel specialistModel = null;
  static KeyvalueModel healthcareProvider = null;

  FindPage({Key key, this.model}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var selectedMinValue;
  List<KeyvalueModel> countryList = [
    KeyvalueModel(name: "India", key: "1"),
    // KeyvalueModel(name: "Bhubaneswar", key: "2"),
    // KeyvalueModel(name: "Puri", key: "3"),
  ];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Odisha", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];
  List<KeyvalueModel> cityList = [
    KeyvalueModel(name: "Cuttack", key: "1"),
    KeyvalueModel(name: "Bhubaneswar", key: "2"),
    KeyvalueModel(name: "Puri", key: "3"),
  ];
  String longitudes;
  String latitudes;
  String address;
  Position position;
  String cityName;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* loginResponse1 = widget.model.loginResponse1;
    callAPI();*/
    
    FindPage.specialistModel=null;
    FindPage.healthcareProvider=null;
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

    /* try {
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      //var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      print("${first.locality}}");
      setState(() {
        address = "${first.addressLine}";
        cityName = first.locality;
        longitudes = position.longitude.toString();
        latitudes = position.altitude.toString();
      });
    } catch (e) {
      print(e.toString());
    }*/
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
            textEditingController[0].text = "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            // longitudes = position.longitude.toString();
            // latitudes = position.altitude.toString();
            longitudes = longi.toString();
            latitudes =  lat.toString();    
            });
        });
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
                              textEditingController[0].text =
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
                GooglePlacesSearchModel googlePlacesSearch = GooglePlacesSearchModel.fromJson(map);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    automaticallyImplyLeading: false,
    title: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            MyLocalizations.of(context).text("FIND"),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      /*  Align(
          alignment: Alignment.topRight,
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/autoComplete");
              },
              child: Icon(Icons.search)),
        ),*/
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
      ],
    ),
    centerTitle: true,
    backgroundColor: AppData.kPrimaryColor,
    iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
    child: Container(
      child: Column(
        children: [
          Container(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/findbooktop.jpg",
                  fit: BoxFit.cover,
                  //centerSlice: ,
                  height: 350,
                  width: double.maxFinite,
                ),
                /*Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: AppData.matruColor.withOpacity(0.7),
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.only(
                      top: 250.0, left: 8.0, right: 8.0, bottom: .0),
                  width: double.maxFinite,
                  /* height: 300,*/
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(8.0),
                      topRight: const Radius.circular(8.0),
                      bottomLeft: const Radius.circular(8.0),
                      bottomRight: const Radius.circular(8.0),
                    ),
                    color: AppData.matruColor,
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Text(MyLocalizations.of(context).text("FIND_HEATH_CARE"),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      NumberformField(address),
                      /*AbsorbPointer(
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: address,
                              hintStyle: TextStyle(color: Colors.black)),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                          ],
                        ),
                      ),*/

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: SizedBox(
                          height: 55,
                          child: DropDown.networkDropdownGetpart4(
                            MyLocalizations.of(context).text("SELECT_HEALTHCARE"),
                              ApiFactory.HEALTHPROVIDER_API,
                              "healthcareProvider", (KeyvalueModel data) {
                            setState(() {
                              print(ApiFactory.HEALTHPROVIDER_API);
                              FindPage.healthcareProvider = data;
                              //DoctorconsultationPage.doctorModel = null;
                              // UserSignUpForm.cityModel = null;
                            });
                          }),
                        ),
                      ),
                      (FindPage.healthcareProvider != null)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: (FindPage.healthcareProvider.key ==
                                          "1" ||
                                      FindPage.healthcareProvider.key ==
                                          "4")
                                  ? SizedBox(
                                      height: 58,
                                      child:
                                          DropDown.networkDropdownGetpart4(
                                              " Select Speciality",
                                              ApiFactory.SPECIALITY_API,
                                              "speciality",
                                              (KeyvalueModel data) {
                                        setState(() {
                                          print(ApiFactory.SPECIALITY_API);
                                          FindPage.specialistModel = data;
                                          //DoctorconsultationPage.doctorModel = null;
                                          // UserSignUpForm.cityModel = null;
                                        });
                                      }),
                                    )
                                  : Container(),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  // ),
                ),
              ],
            ),
          ),
          /* Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Find and Book',
                  style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Image.asset(
                      "assets/logo1.png",
                      fit: BoxFit.fitWidth,
                      //width: ,
                      height: 110.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                AbsorbPointer(
                  child: TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: address,
                        hintStyle: TextStyle(color: Colors.black)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child: DropDown.networkDropdownGetpartUserundreline(
                        "Select Healthcare Provider",
                        ApiFactory.HEALTHPROVIDER_API,
                        "healthcareProvider", (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.HEALTHPROVIDER_API);
                        FindPage.healthcareProvider = data;
                        //DoctorconsultationPage.doctorModel = null;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                (FindPage.healthcareProvider != null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: (FindPage.healthcareProvider.key == "1" ||
                                FindPage.healthcareProvider.key == "4")
                            ? SizedBox(
                                height: 58,
                                child: DropDown
                                    .networkDropdownGetpartUserundreline(
                                        " Select Speciality",
                                        ApiFactory.SPECIALITY_API,
                                        "speciality", (KeyvalueModel data) {
                                  setState(() {
                                    print(ApiFactory.SPECIALITY_API);
                                    FindPage.specialistModel = data;
                                    //DoctorconsultationPage.doctorModel = null;
                                    // UserSignUpForm.cityModel = null;
                                  });
                                }),
                              )
                            : Container(),
                      )
                    : Container(),
                */ /*DropDown.staticDropdown2(
                    "Select Speciality", "state", cityList,
                    (KeyvalueModel data) {
                  setState(() {});
                }),*/ /*
                SizedBox(
                  height: 60,
                ),
                _submitButton(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),*/
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
        /*child:AbsorbPointer(
          child: TextFormField(
            maxLines: 3,
            controller: textEditingController[index],
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
            ],
            decoration: InputDecoration(
              */ /* suffixIcon: Icon(Icons.phone),*/ /*
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.black)
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),),*/
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton3(
        text: MyLocalizations.of(context).text("SEARCH").toUpperCase(),
        context: context,
        fun: () {
          if (FindPage.healthcareProvider == null ||
              FindPage.healthcareProvider == "") {
            AppData.showInSnackBar(
                context, "Please select healthcare provider");
          } else if (FindPage.specialistModel == null ||
              FindPage.specialistModel == "") {
            AppData.showInSnackBar(context, "Please select speciality");
          } else {
            /* else if(FindScreen.healthcareProvider != null || FindScreen.healthcareProvider != ""
        && FindScreen.specialistModel == "" || FindScreen.specialistModel == null){
      AppData.showInSnackBar(context,"Select Speciality");*/ /*
    }else {*/
            /*if (FindScreen.healthcareProvider == null ||
              FindScreen.healthcareProvider == "") {
            AppData.showInSnackBar(context, "Select healthcare Provider");
          } else {*/
            widget.model.longi = longitudes;
            widget.model.lati = latitudes;
            widget.model.addr = address;
            widget.model.city = cityName;
            widget.model.type = FindPage?.specialistModel?.key ?? "";
            widget.model.healthpro = FindPage.healthcareProvider.key;
            widget.model.healthproname = FindPage.healthcareProvider.name;
            //widget.model.healthproname = "Doctor";

            //Navigator.pushNamed(context, "/navigation");
            /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/
            print('------------ longitudes Narmada ' + latitudes + "," +
                longitudes);
            Navigator.pushNamed(context, "/chemistspage");
            //Navigator.pushNamed(context, "/searchScreen");
          }
          /* }*/
        }
        // },
        );
  }
}
