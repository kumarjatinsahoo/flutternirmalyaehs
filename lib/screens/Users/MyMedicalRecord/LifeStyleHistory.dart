import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LifeStyleHistryModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class LifeStyleHistory extends StatefulWidget {
  final MainModel model;

  // final Choice choice;
  static KeyvalueModel smokingmodel = null;
  static KeyvalueModel alcoholmodel = null;
  static KeyvalueModel ditemodel = null;
  static KeyvalueModel petsmodel = null;
  static KeyvalueModel genderModel = null;

  const LifeStyleHistory({Key key, this.model}) : super(key: key);

  @override
  _LifeStyleHistoryState createState() => _LifeStyleHistoryState();
}

class _LifeStyleHistoryState extends State<LifeStyleHistory> {
  int _selectedDestination = -1;
  int count = 0;
  LifeStyleHistryModel lifeStyleHistryModel;
  List<String> strOrders = [
    'My Orders',
    'Confirm Orders',
    'Processed Orders',
    'Delivered Orders',
    'Delivered Orders1'
  ];
  List<String> strOthers1 = [
    'Invoices',
    'Monthly Review',
    'Offfers and Discount',
    'Online Chat',
    'Daily Sales'
  ];
  String valueText = null;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  bool isShown = true;
  List<KeyvalueModel> genderList = [
    KeyvalueModel(key: "1", name: "Veg"),
    KeyvalueModel(key: "2", name: "Non Veg"),
  ];
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _bmi = TextEditingController();
  TextEditingController _tempreture = TextEditingController();
  TextEditingController _systolicbloodpressure = TextEditingController();
  TextEditingController _diastolicbloodpressure = TextEditingController();
  TextEditingController _pulse = TextEditingController();
  TextEditingController _respiration = TextEditingController();
  TextEditingController _oxygensaturation = TextEditingController();

  // VITAL_SIGN_DETAIS
  void initState() {
    // TODO: implement initState
    super.initState();
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IIFESTYLE_DETAIS + widget.model.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Response >>>>"+jsonEncode(map));
          setState(() {
            //String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              lifeStyleHistryModel = LifeStyleHistryModel.fromJson(map);
              print('exercise ' + lifeStyleHistryModel.body.exercise);
              if (lifeStyleHistryModel?.body?.smokingName != null) {
                LifeStyleHistory.smokingmodel = KeyvalueModel(
                    key: lifeStyleHistryModel.body.smokingId,
                    name: lifeStyleHistryModel.body.smokingName);
              } else {
                LifeStyleHistory.smokingmodel = null;
              }
              if (lifeStyleHistryModel?.body?.alcoholName != null) {
                LifeStyleHistory.alcoholmodel = KeyvalueModel(
                    key: lifeStyleHistryModel.body.alcoholId,
                    name: lifeStyleHistryModel.body.alcoholName);
              } else {
                LifeStyleHistory.alcoholmodel = null;
              }
              if (lifeStyleHistryModel?.body?.diet != null) {
                LifeStyleHistory.ditemodel = KeyvalueModel(
                    // key: lifeStyleHistryModel.body.,
                    name: lifeStyleHistryModel.body.diet);
              } else {
                LifeStyleHistory.ditemodel = null;
              }
              //  if (lifeStyleHistryModel?.body?.exercise != null) {
              //   lifeStyleHistryModel.body.exercise = textEditingController[0].text;
              // } else {
              //   lifeStyleHistryModel.body.exercise = "N/A";
              // }
              if (lifeStyleHistryModel?.body?.petName != null) {
                LifeStyleHistory.petsmodel = KeyvalueModel(
                    key: lifeStyleHistryModel.body.pets,
                    name: lifeStyleHistryModel.body.petName);
              } else {
                LifeStyleHistory.petsmodel = null;
              }
              //appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              //AppData.showInSnackBar(context, "Data Not Found");
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: Text(
                MyLocalizations.of(context).text("LIFESTYLE_HISTORY"),
                style: TextStyle(color: AppData.white),
              ),
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              iconTheme: IconThemeData(color: AppData.white),
              actions: <Widget>[
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(20.00),
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialogaddnomination(context),
                    );
                    //dialogaddnomination(context);
                  },
                ),
              ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    //height: double.maxFinite,
                    //mainAxisSize:MainAxisSize.max,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 5, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTile1(
                                      icon: "assets/smoking.png",
                                      title: (lifeStyleHistryModel?.body == null ||
                                              lifeStyleHistryModel.body.smokingName
                                                      .toString() == "")? "N/A"
                                          : lifeStyleHistryModel.body.smokingName
                                              .toString(),
                                      subtitle: MyLocalizations.of(context)
                                          .text("SMOKING"),
                                      fun: () {
                                        /*Navigator.pushNamed(
                                        context, "/patientRegistration");*/
                                        // Navigator.pushNamed(context, "/walkRegList");
                                      },
                                      color: Color(0xFFCF3564),
                                      bordercolor: AppData.grey100,
                                      // ,
                                    ),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTile1(
                                      icon: "assets/alcohol.png",
                                      title: (lifeStyleHistryModel?.body == null ||
                                              lifeStyleHistryModel.body.alcoholName
                                                      .toString() == "0") ? "N/A"
                                          : lifeStyleHistryModel.body.alcoholName
                                              .toString(),
                                      subtitle: MyLocalizations.of(context)
                                          .text("ALCOHOL"),
                                      fun: () {
                                        // chooseAppointment(context);
                                        // Navigator.pushNamed(context, "/medicalrecordpage");
                                      },
                                      color: Color(0xFF2372B6),
                                      bordercolor: AppData.BG1RED,
                                      // ,
                                    ),
                                  ]),
                            ],
                          ),
                          SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTile1(
                                      //icon: Icons.document_scanner,
                                      icon: "assets/diet.png",
                                      title: (lifeStyleHistryModel?.body == null ||
                                              lifeStyleHistryModel.body.diet
                                                      .toString() == "0") ? "N/A"
                                          : lifeStyleHistryModel.body.diet.toString(),
                                      subtitle:
                                          MyLocalizations.of(context).text("DIET"),
                                      fun: () {
                                        /*Navigator.pushNamed(
                                            context, "/pocreportlist");*/
                                      },
                                      color: Color(0xFF2372B6),
                                      bordercolor: AppData.BG1RED,
                                      // ,
                                    ),
                                  ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTile1(
                                    icon: "assets/exercise.png",
                                    title: (lifeStyleHistryModel?.body == null ||
                                              lifeStyleHistryModel?.body.exercise
                                                      .toString() ==
                                                  "0")
                                    //  (lifeStyleHistryModel?.body == null ||
                                    //         lifeStyleHistryModel?.body.exercise.toString() == "0")
                                        ? "N/A"
                                        : lifeStyleHistryModel.body.exercise.toString() +
                                            " times",
                                    subtitle: MyLocalizations.of(context)
                                        .text("EXERCISE"),
                                    fun: () {
                                      //chooseAppointment1(context);
                                      /* Navigator.pushNamed(
                                          context, "/testappointmentpage");*/
                                    },
                                    color: Color(0xFFCF3564),

                                    bordercolor: AppData.BG2BLUE,
                                    // ,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTile1(
                                      //icon: Icons.document_scanner,
                                      icon: "assets/occupation.png",
                                      title: (lifeStyleHistryModel?.body == null ||
                                              lifeStyleHistryModel.body.occupation
                                                      .toString() ==
                                                  "0")
                                          ? "N/A"
                                          : lifeStyleHistryModel.body.occupation
                                              .toString(),
                                      subtitle: MyLocalizations.of(context)
                                          .text("OCCUPATION"),
                                      fun: () {
                                        /*Navigator.pushNamed(
                                            context, "/pocreportlist");*/
                                      },
                                      color: Color(0xFFCF3564),
                                      // color: Color(0xFF2372B6),
                                      bordercolor: AppData.BG1RED,
                                      // ,
                                    ),
                                  ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTile1(
                                    icon: "assets/pet.png",
                                    title: (lifeStyleHistryModel?.body == null ||
                                            lifeStyleHistryModel?.body.petName
                                                    .toString() ==
                                                "0")
                                        ? "N/A"
                                        : lifeStyleHistryModel.body.petName.toString(),
                                    subtitle:
                                        MyLocalizations.of(context).text("PETS"),
                                    fun: () {
                                      //chooseAppointment1(context);
                                      /* Navigator.pushNamed(
                                          context, "/testappointmentpage");*/
                                    },
                                    //color: Color(0xFFCF3564),
                                    color: Color(0xFF2372B6),
                                    bordercolor: AppData.BG2BLUE,
                                    // ,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        (isShown)?Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black54,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isShown = false;
              });
            },
          ),
        ):Container(),
        Positioned(
            right: 22,
            top: 12,
            child: Visibility(
              visible: isShown,
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isShown = false;
                    });
                  },
                  enableFeedback: false,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Visibility(
                      visible: isShown,
                      child: SafeArea(
                          child:
                          Image.asset("assets/images/indicationupdate.png")))),
            ))
      ],
    );
  }

  Widget _buildTile1(
      {String icon,
      String title,
      String subtitle,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(0.0),
          /* height: MediaQuery.of(context).size.height * 0.23,*/
          height: 155,
          width: (MediaQuery.of(context).size.width - 50) / 2,
          decoration: BoxDecoration(
            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(1.0),
              topRight: Radius.circular(1.0),
              bottomLeft: Radius.circular(1.0),
              bottomRight: Radius.circular(1.0),
            ),
            //color: AppData.grey100,
            color: AppData.white,

            /* border: Border.all(
              color: AppData.kPrimaryColor,
              width: 1.0,
            )*/
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Material(
                      color: color,
                      elevation: 10,
                      child: new Image.asset(
                        icon,
                        height: 40,
                        fit: BoxFit.cover,
                        // color: Colors.blue
                      ),
                    ),
                  ]),
                  /* Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0, color:color
                  ),),*/
                  // Icon(icon, color:color, size: 40.0),                                                Material(
                  /*Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Monte",
                    fontSize: 22.0,
                  ),

                ),*/
                  SizedBox(height: 10.0),
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD8ABAF),
                            width: 1.0, // Underline thickness
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
        /*  Card(
          elevation: 2,

          child: Container(
            decoration: BoxDecoration(
              color: AppData.grey100,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: InkWell(
                onTap: (){
                  // Navigator.pushNamed(context, "/deliveredorder");
                },
                child: Container(
                  child: new GridTile(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              */ /* count % 2 == 1 ??*/ /*
                                color:choices[index].color,
                                padding: EdgeInsets.all(3),
                                child: Image.asset(choices[index].icon,height: 40,)
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02,),
                        Text( choices[index].title.toString(),
                          style: TextStyle( color: Colors.black,fontSize: 15),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                        SizedBox(height: size.height * 0.01,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFD8ABAF),
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02,),
                        Text( choices[index].title1.toString(),
                          style: TextStyle( color: Colors.grey,fontSize: 12),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                      ],
                    ),

                  ),
                ),
              ),
            ),
          ),
        );*/
      ),
    );
  }

  Widget dialogaddnomination(BuildContext context) {
    // DoctorMedicationlistModel item = DoctorMedicationlistModel();
    /*lifeStyleHistryModel?.body.exercise.toString()==null?"N/A":textEditingController[0].text=lifeStyleHistryModel?.body.exercise.toString();
    lifeStyleHistryModel?.body.occupation.toString()==null?"N/A": textEditingController[1].text=lifeStyleHistryModel.body.occupation.toString();
    lifeStyleHistryModel?.body.pets.toString()==null?"N/A":textEditingController[2].text=lifeStyleHistryModel.body.pets.toString();*/
    lifeStyleHistryModel != null
        ? textEditingController[0].text =
            lifeStyleHistryModel.body.exercise.toString() ?? "N/A"
        : textEditingController[0].text = "N/A";
    lifeStyleHistryModel != null
        ? textEditingController[1].text =
            lifeStyleHistryModel.body.occupation.toString() ?? "N/A"
        : textEditingController[1].text = "N/A";
    /*lifeStyleHistryModel != null
        ? textEditingController[2].text = lifeStyleHistryModel.body.pets.toString() ?? "N/A"
        : textEditingController[2].text = "N/A";*/


    /* textEditingController[1].text=lifeStyleHistryModel.body.occupation.toString() ?? "N/A";
    textEditingController[2].text=lifeStyleHistryModel.body.pets.toString() ?? "N?A";*/

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //_buildAboutText(),
                  //_buildLogoAttribution(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      MyLocalizations.of(context).text("UPDATE_LIFESTYLE"),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(MyLocalizations.of(context).text("SMOKING")),
                  ),
                  Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child: DropDown.networkDropdownlabler1(
                        MyLocalizations.of(context).text("SMOKING"),
                        ApiFactory.smoking_API,
                        "smoking", (KeyvalueModel model) {
                      print(ApiFactory.smoking_API);
                      setState(() {
                        LifeStyleHistory.smokingmodel = model;
                        lifeStyleHistryModel.body.smokingId = model.key;
                        lifeStyleHistryModel.body.smokingName = model.name;
                        // updateProfileModel.eRelation = model.key;
                      });
                    }),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(MyLocalizations.of(context).text("ALCOHOL")),
                  ),
                  Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child: DropDown.networkDropdownlabler1(
                        MyLocalizations.of(context).text("ALCOHOL"),
                        ApiFactory.alchohol_API,
                        "alcohol", (KeyvalueModel model) {
                      setState(() {
                        LifeStyleHistory.alcoholmodel = model;
                        lifeStyleHistryModel.body.alcoholId = model.key;
                        lifeStyleHistryModel.body.alcoholName = model.name;
                        // updateProfileModel.eRelation = model.key;
                      });
                    }),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(MyLocalizations.of(context).text("DIET")),
                  ),

                  gender(),
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: DropDown.staticDropdown3(
                        "QTY", "callFrom", spinnerItems, (value) {
                      setState(() {
                        //qtyData = value.name;
                      });
                    }),
                  ),*/
                  SizedBox(
                    height: 5,
                  ),
                  formFieldMobile(
                      0, MyLocalizations.of(context).text("EXERCISE")),
                  SizedBox(
                    height: 5,
                  ),
                  // formField(1, MyLocalizations.of(context).text("OCCUPATION")),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  //formField(2, MyLocalizations.of(context).text("PETS")),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text( MyLocalizations.of(context).text("PETS")),
                  ),
                  Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child: DropDown.networkDropdownlabler1(
                        MyLocalizations.of(context).text("PETS"),
                        ApiFactory.PETLIST_API,
                        "pets", (KeyvalueModel model) {
                      setState(() {
                        LifeStyleHistory.petsmodel = model;
                        lifeStyleHistryModel.body.pets = model.key;
                        lifeStyleHistryModel.body.petName = model.name;
                        // updateProfileModel.eRelation = model.key;
                      });
                    }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
            // textEditingController[0].text = "";
            //  lifeStyleHistryModel.body.smokingName=null;
            //  lifeStyleHistryModel.body.alcoholName=null;
            // lifeStyleHistryModel.body.diet=null;
            // lifeStyleHistryModel.body.exercise=null;
            // lifeStyleHistryModel.body.pets=null;
            callAPI();
          },
          child: Text(MyLocalizations.of(context).text("CANCEL"),
              style: TextStyle(color: AppData.kPrimaryRedColor)),
        ),
        new FlatButton(
          child: Text(MyLocalizations.of(context).text("UPDATE"),
            //style: TextStyle(color: Colors.grey),
            style: TextStyle(color: AppData.matruColor),
          ),
          onPressed: () {
            //AppData.showInSnackBar(context, "click");
            setState(() {
              if (LifeStyleHistory.smokingmodel.name == "N/A" || LifeStyleHistory.smokingmodel == null ||
                  LifeStyleHistory.smokingmodel == "") {
                AppData.showInSnackBar(context, "Please select smoking");
              } else if (LifeStyleHistory.alcoholmodel == null ||
                  LifeStyleHistory.alcoholmodel == "" || LifeStyleHistory.alcoholmodel.name == "N/A") {
                AppData.showInSnackBar(context, "Please select alcohol");
              } else if (LifeStyleHistory.ditemodel == null ||
                  LifeStyleHistory.ditemodel == "" || LifeStyleHistory.ditemodel.name == "N/A") {
                AppData.showInSnackBar(context, "Please select diet");
              } else if (textEditingController[0].text == "N/A" ||
                  textEditingController[0].text == null ||
                  textEditingController[0].text == "") {
                AppData.showInSnackBar(context, "Please enter exercise");
              }else if (LifeStyleHistory.petsmodel.name == "N/A" || LifeStyleHistory.petsmodel == null ||
              LifeStyleHistory.petsmodel == "") {
              AppData.showInSnackBar(context, "Please select pets");
               }
              // } else if (textEditingController[1].text == "N/A" ||
              //     textEditingController[1].text == null ||
              //     textEditingController[1].text == "") {
              //   AppData.showInSnackBar(context, "Please enter  Occupation");
              /*} else if (textEditingController[2].text == "N/A" ||
                  textEditingController[2].text == null ||
                  textEditingController[2].text == "") {
                AppData.showInSnackBar(context, "Please enter  Pets");
              }*/ else {
                lifeStyleHistryModel.body.exercise = textEditingController[0].text;
                print('send exercise ' + lifeStyleHistryModel.body.exercise);
                var sendData = {
                  "smokingId": LifeStyleHistory.smokingmodel.key,
                  "alcoholId": LifeStyleHistory.alcoholmodel.key,
                  "pets": LifeStyleHistory.petsmodel.key,
                  "diet": LifeStyleHistory.ditemodel.name,
                  "exercise": textEditingController[0].text,
                  //"occupation": textEditingController[1].text,
                  //"pets": textEditingController[2].text,
                  "patientId": widget.model.user,
                };

                log("API NAME>>>>" + ApiFactory.patient_lifestyle_details);
                log("TO POST>>>>" + jsonEncode(sendData));
                MyWidgets.showLoading(context);
                // Navigator.pop(context);
                widget.model.POSTMETHOD_TOKEN(
                    api: ApiFactory.patient_lifestyle_details,
                    json: sendData,
                    token: widget.model.token,
                    fun: (Map<String, dynamic> map) {
                      
                      String msg = map["message"].toString();
                      /*setState(() {
                        if (map[Const.STATUS1] == Const.SUCCESS) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          callAPI();
                          AppData.showInSnackBargreen(
                              context, map[Const.MESSAGE]);

                        } else {
                          callAPI();
                          AppData.showInSnackBar(context, map[Const.MESSAGE]);
                        }
                      });*/
                    /*});*/
                     
                        if (map[Const.CODE] == Const.SUCCESS) {
                           setState(() {
                          //Navigator.pop(context);
                          // AppData.showInSnackDone(context, map["message"]);
                           popup(msg, context);
                          callAPI();
                          //AppData.showInSnackDone(context, map[Const.MESSAGE]);
                          //AppData.showInSnackBargreen(context,"chs");
                        });
                        } else {
                          //AppData.showInSnackBar(context,/* map[Const.MESSAGE]*/"gkhyjjd");
                        }
                      
                    },
                  /*fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    callAPI();
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);

                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  }*/
                );
                // callAPI();
                Navigator.of(context).pop();

              }

            });
            },


        ),
      ],
    );
  }
popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        //title: "Success",
        title: "Success",
        //type: AlertType.info,
        onWillPopActive: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 140,
              color: Colors.green,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              msg,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
           
          ],
        ),
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
  Widget gender() {
    return DropDown.staticDropdown3(
        MyLocalizations.of(context).text("DIET"), "diet", genderList,
        (KeyvalueModel model) {
          LifeStyleHistory.ditemodel = model;
          lifeStyleHistryModel.body.alcoholId = model.key;
          lifeStyleHistryModel.body.diet = model.name;
      //lifeStyleHistryModel.body.smokingId = model.key;
      //LifeStyleHistory.ditemodel = model;
    });
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hint),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppData.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      //enabled: widget.isConfirmPage ? false : true,
                      controller: textEditingController[index],
                      //focusNode: fnode7,
                      cursorColor: AppData.kPrimaryColor,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                      ],
                      decoration: InputDecoration(
                        //suffixIcon: Icon(Icons.phone),
                        border: InputBorder.none,
                        counterText: "",
                        hintText: hint,
                        hintStyle:
                            TextStyle(color: AppData.hintColor, fontSize: 15),
                      ),

                      onFieldSubmitted: (value) {
                        // print(error[2]);
                        //error[4] = false;
                        setState(() {});
                        // AppData.fieldFocusChange(context, fnode7, fnode8);
                      },
                      onSaved: (value) {
                        //userPersonalForm.phoneNumber = value;
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formFieldMobile(
    int index,
    String hint,
  ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hint),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppData.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      //enabled: widget.isConfirmPage ? false : true,
                      controller: textEditingController[index],
                      //focusNode: fnode7,
                      cursorColor: AppData.kPrimaryColor,
                      textInputAction: TextInputAction.next,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0-9 .]")),
                      ],
                      decoration: InputDecoration(
                        //suffixIcon: Icon(Icons.phone),
                        border: InputBorder.none,
                        counterText: "",
                        hintText: hint+" (times)",
                        hintStyle:
                            TextStyle(color: AppData.hintColor, fontSize: 15),
                      ),

                      onFieldSubmitted: (value) {
                        // print(error[2]);
                        //error[4] = false;
                        setState(() {});
                        // AppData.fieldFocusChange(context, fnode7, fnode8);
                      },
                      onSaved: (value) {
                        //userPersonalForm.phoneNumber = value;
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    //    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Update Vital Sign",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            _height.text = value;
                          });
                        },
                        controller: _height,
                        decoration: InputDecoration(hintText: "Height"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                            _weight.text = value;
                          });
                        },
                        controller: _weight,
                        decoration: InputDecoration(hintText: "Weight"),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        // onChanged: (value) {
                        //   setState(() {
                        //    //valueText = value;
                        //    _bmi.text = value;
                        //   });
                        // },
                        controller: _bmi,
                        decoration: InputDecoration(hintText: "BMI(KG/m)"),
                      ),
                      Divider(height: 2, color: Colors.black),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                            _tempreture.text = value;
                          });
                        },
                        controller: _tempreture,
                        decoration: InputDecoration(hintText: "Temprature"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            _systolicbloodpressure.text = value;
                          });
                        },
                        controller: _systolicbloodpressure,
                        decoration: InputDecoration(
                            hintText: "Systolic Blood Pressure"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                            _diastolicbloodpressure.text = value;
                          });
                        },
                        controller: _diastolicbloodpressure,
                        decoration: InputDecoration(
                            hintText: "Diastolic Blood Pressure"),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            _pulse.text = value;
                          });
                        },
                        controller: _pulse,
                        decoration: InputDecoration(hintText: " Pulse"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            _respiration.text = value;
                          });
                        },
                        controller: _respiration,
                        decoration: InputDecoration(hintText: " Respiration"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            _oxygensaturation.text = value;
                          });
                        },
                        controller: _oxygensaturation,
                        decoration:
                            InputDecoration(hintText: " Oxygen Saturation"),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child:
                    Text('CANCEL', style: TextStyle(color: Color(0xFF2372B6))),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  'OK',
                  style: TextStyle(color: Color(0xFF2372B6)),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {});
                },
              ),
            ],
          );
        });
  }
}
