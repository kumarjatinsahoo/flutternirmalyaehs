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

import 'Doctor/Dashboard/DoctorMedicationlist.dart';

class FindPage1 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel specialistModel = null;
  static KeyvalueModel healthcareProvider = null;

  FindPage1({Key key, this.model}) : super(key: key);

  @override
  _FindPage1State createState() => _FindPage1State();
}

class _FindPage1State extends State<FindPage1> {
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
    latitudes=position.latitude.toString();
    longitudes=position.longitude.toString();
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
            textEditingController[0].text = "${finder.formattedAddress}";
            cityName = finder.addressComponents[4].longName;
            print("finder>>>>>>>>>" + finder.addressComponents[4].longName);
            longitudes = position.longitude.toString();
            latitudes = position.altitude.toString();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/bg_img.jpg",
                  fit: BoxFit.cover,
                  //centerSlice: ,
                  height: 280,
                  width: double.maxFinite,
                ),
                /*Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: AppData.matruColor.withOpacity(0.7),
                  ),
                ),*/
                Container(
                  margin:
                  EdgeInsets.only(top: 265.0, left: 8.0, right: 8.0, bottom: .0),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(8.0),
                      topRight: const Radius.circular(8.0),
                      bottomLeft: const Radius.circular(8.0),
                      bottomRight: const Radius.circular(8.0),
                    ),
                    /*image: DecorationImage(
                image: AssetImage(
                  "assets/card.png",
                ),
                fit: BoxFit.fitWidth,
              ),*/
                    /*gradient: LinearGradient(
                colors: [AppData.matruColor, Colors.black54],
              ),*/
                    color: AppData.matruColor,
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                height: 20.0,
              ),
                      Text(
                        'Find Healthcare Provider',
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w300,color: Colors.white),
                      ),
                      NumberformField(0,''),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: SizedBox(
                          height: 55,
                          child: DropDown.networkDropdownGetpart4(
                              "Select Healthcare Provider",
                              ApiFactory.HEALTHPROVIDER_API,
                              "healthcareProvider", (KeyvalueModel data) {
                            setState(() {
                              print(ApiFactory.HEALTHPROVIDER_API);
                              FindPage1.healthcareProvider = data;
                              //DoctorconsultationPage.doctorModel = null;
                              // UserSignUpForm.cityModel = null;
                                });
                              }),
                        ),
                      ),
                      (FindPage1.healthcareProvider != null)
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: (FindPage1.healthcareProvider.key == "1" ||
                            FindPage1.healthcareProvider.key == "4")
                            ? SizedBox(
                          height: 58,
                          child: DropDown
                              .networkDropdownGetpart4(
                              " Select Speciality",
                              ApiFactory.SPECIALITY_API,
                              "speciality", (KeyvalueModel data) {
                            setState(() {
                              print(ApiFactory.SPECIALITY_API);
                              FindPage1.specialistModel = data;
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
                    height: 10,),
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
                DropDown.staticDropdown2(
                    "Select Speciality", "state", cityList,
                    (KeyvalueModel data) {
                  setState(() {});
                }),
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
  Widget NumberformField(
      int index,
      String hint,
      ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
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
          child:AbsorbPointer(
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
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.black)
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),),
        ) /*),*/
    );
  }
  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin:
            EdgeInsets.only(top: 100.0, left: 10.0, right: 10.0, bottom: .0),
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: const Radius.circular(15.0),
                bottomRight: const Radius.circular(15.0),
              ),
              /*image: DecorationImage(
                  image: AssetImage(
                    "assets/card.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),*/
              /*gradient: LinearGradient(
                  colors: [AppData.matruColor, Colors.black54],
                ),*/
              color: AppData.matruColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height: 45.0,
                ),*/
                Text(
                  "sg",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "AADHAAR NO" +
                      ": " +
                     "N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
            // ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(model.profileImageName??AppData.defaultImgUrl),
                ),
              ),
            ],
          ),*/
        ],
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

  Widget _submitButton() {
    return MyWidgets.nextButton3(
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
            widget.model.type = FindPage1?.specialistModel?.key ?? "";
            widget.model.healthpro = FindPage1.healthcareProvider.key;
            widget.model.healthproname = FindPage1.healthcareProvider.name;
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
