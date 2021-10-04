import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

import 'package:geolocator/geolocator.dart' as loca;
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

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
    _getLocationName();
  }

  _getLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print(
        'location>>>>>>>>>>>>>>>>>>: ${position.latitude},${position.longitude}');
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
    print(">>>>>>>>>" + ApiFactory.GOOGLE_LOC(lat: lat, long: longi));
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_LOC(lat: lat, long: longi),
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          ResultsServer finder = ResultsServer.fromJson(map["results"][0]);
          print("finder>>>>>>>>>" + finder.toJson().toString());

          setState(() {
            address = "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
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
        title: Text(
          'Find',
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
                    /*DropDown.staticDropdown2(
                        "Select Speciality", "state", cityList,
                        (KeyvalueModel data) {
                      setState(() {});
                    }),*/
                    SizedBox(
                      height: 60,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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

  Widget _submitButton() {
    return MyWidgets.nextButton(
        text: "search".toUpperCase(),
        context: context,
        fun: () {
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
            Navigator.pushNamed(context, "/chemistspage");
            //Navigator.pushNamed(context, "/searchScreen");
          }
       /* }*/

        // },
        );
  }
}
