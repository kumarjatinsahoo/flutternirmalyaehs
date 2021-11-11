
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LifeStyleHistryModel.dart';
import 'package:user/models/UserVitalsignsModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class LifeStyleHistory extends StatefulWidget {
  final MainModel model;
  final bool isConfirmPage;
 // final Choice choice;
  static KeyvalueModel smokingmodel = null;
  static KeyvalueModel alcoholmodel = null;
  static KeyvalueModel ditemodel = null;


  const LifeStyleHistory({Key key, this.model,this.isConfirmPage= false}) : super(key: key);

  @override
  _LifeStyleHistoryState createState() => _LifeStyleHistoryState();
}

class _LifeStyleHistoryState extends State<LifeStyleHistory> {
  int _selectedDestination = -1;
  int count = 0;
  LifeStyleHistryModel lifeStyleHistryModel;
  List<String> strOrders = ['My Orders', 'Confirm Orders', 'Processed Orders','Delivered Orders','Delivered Orders1'];
  List<String> strOthers1 = ['Invoices','Monthly Review','Offfers and Discount', 'Online Chat', 'Daily Sales'];
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
    setState(() {

      callAPI();
    });
  }
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IIFESTYLE_DETAIS + widget.model.user ,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              lifeStyleHistryModel = LifeStyleHistryModel.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Life Style History",
          style: TextStyle(color: AppData.white),
        ),
        centerTitle: true,
        backgroundColor:AppData.kPrimaryColor,
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
              onTap:() async{
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialogaddnomination(context),
                );
               // dialogaddnomination(context);



              },
            ),
]
      ),

      body:   SingleChildScrollView(

        child: Column(
          children: [

            SingleChildScrollView(
              child: Container(

            width: double.infinity,
            height: double.maxFinite,
                //mainAxisSize:MainAxisSize.max,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 5,left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:MainAxisSize.max,
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
                                  title: (lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.smokingName.toString()=="")
                      ?"N/A": lifeStyleHistryModel.body.smokingName.toString() ,
                                  subtitle:"Smoking",
                                  fun: () {
                                    /*Navigator.pushNamed(
                                    context, "/patientRegistration");*/
                                   // Navigator.pushNamed(context, "/walkRegList");
                                  },
                                  color:Color(0xFFCF3564),
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
                                  title:(lifeStyleHistryModel?.body == null|| lifeStyleHistryModel.body.alcoholName.toString()=="0")
                                      ? "N/A":lifeStyleHistryModel.body.alcoholName.toString(),
                                  subtitle:"Alcohol",
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
                                  title: (lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.diet.toString()=="0")
                                      ?"N/A" :lifeStyleHistryModel.body.diet.toString() ,
                                  subtitle:"Dite",
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
                                title: (lifeStyleHistryModel?.body == null || lifeStyleHistryModel?.body.exercise.toString()=="0")
                                    ?"N/A": lifeStyleHistryModel.body.exercise.toString()+" times",
                                subtitle:"Exercise",
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
                                  title: (lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.occupation.toString()=="0")
                                      ?"N/A" :lifeStyleHistryModel.body.occupation.toString() ,
                                  subtitle:"Occupation",
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
                                title: (lifeStyleHistryModel?.body == null || lifeStyleHistryModel?.body.pets.toString()=="0")
                                    ?"N/A": lifeStyleHistryModel.body.pets.toString(),
                                subtitle:"Pets",
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
        child:Container(
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
            )*/),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color:color,
                      elevation: 10,
                      child: new Image.asset(
                        icon,
                        height: 40,
                        fit: BoxFit.cover,
                        // color: Colors.blue
                      ),
                    ),
  ]
        ),
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
                Text(title,
                  style: TextStyle( color: Colors.black,fontSize: 15),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
                SizedBox(height:5.0),
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
                Text( subtitle,
                  style: TextStyle( color: Colors.grey,fontSize: 12),
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
                              *//* count % 2 == 1 ??*//*
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
   /* vitalsignsModel.body[0].height.toString()=="0.0"?"N/A":textEditingController[0].text=vitalsignsModel.body[0].height.toString();
    vitalsignsModel.body[0].weight.toString()=="0.0"?"N/A": textEditingController[1].text=vitalsignsModel.body[0].weight.toString();
    vitalsignsModel.body[0].bmi.toString()=="0.0"?"N/A":textEditingController[2].text=vitalsignsModel.body[0].bmi.toString();
    vitalsignsModel.body[0].tempcel.toString()=="0.0"?"N/A":textEditingController[3].text=vitalsignsModel.body[0].tempcel.toString();
    vitalsignsModel.body[0].sysbp.toString()=="0"?"N/A":textEditingController[4].text=vitalsignsModel.body[0].sysbp.toString();
    vitalsignsModel.body[0].diabp.toString()=="0"?"N/A":textEditingController[5].text=vitalsignsModel.body[0].diabp.toString();
    vitalsignsModel.body[0].pulse.toString()=="0"?"N/A": textEditingController[6].text=vitalsignsModel.body[0].pulse.toString();
    vitalsignsModel.body[0].respiartion.toString()=="0"?"N/A":textEditingController[7].text=vitalsignsModel.body[0].respiartion.toString();
    vitalsignsModel.body[0].oxygen.toString()=="0"?"N/A":textEditingController[8].text=vitalsignsModel.body[0].oxygen.toString();*/
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
                  Text("Update Life Style History",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding:
                const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                child:DropDown.networkDropdownlabler1(
                      "Smoking", ApiFactory.smoking_API, "smoking",
                          (KeyvalueModel model) {
                        setState(() {
                          LifeStyleHistory.smokingmodel = model;
                         /* patientProfileModel.body.eRelationId = model.key;
                          patientProfileModel.body.eRelation = model.name;*/
                          // updateProfileModel.eRelation = model.key;
                        });
                      }),
              ),

                  Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding:
                    const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                    child:DropDown.networkDropdownlabler1(
                        "Alcohol", ApiFactory.alchohol_API, "alcohol",
                            (KeyvalueModel model) {
                          setState(() {
                            LifeStyleHistory.alcoholmodel = model;
                            /* patientProfileModel.body.eRelationId = model.key;
                          patientProfileModel.body.eRelation = model.name;*/
                            // updateProfileModel.eRelation = model.key;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  formFieldMobile(0, "Exercise"),
                  SizedBox(
                    height: 8,
                  ),
                  formField(1,"Occupation"),
                  SizedBox(
                    height: 8,
                  ),
                  formField(2,"Pets"),
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
          },
          textColor: Theme.of(context).primaryColor,
          child:Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          onPressed: () {
              var sendData =
              {
                    "smokingId":LifeStyleHistory.smokingmodel.key,
                    "alcoholId":LifeStyleHistory.alcoholmodel.key,
                    "diet":"Vag",
                    "exercise": textEditingController[0].text,
                    "occupation": textEditingController[1].text,
                    "pets": textEditingController[2].text,
                    "patientId": widget.model.user,
                  };

              log("API NAME>>>>" + ApiFactory.patient_lifestyle_details);
              log("TO POST>>>>" + jsonEncode(sendData));
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.patient_lifestyle_details,
                  json: sendData,
                  token: widget.model.token,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  setState(() {
                    if (map[Const.STATUS1] == Const.SUCCESS) {
                      //Navigator.pop(context);
                      callAPI();
                      AppData.showInSnackBargreen(context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
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
              callAPI();
            Navigator.of(context).pop();
           // textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child:Text(MyLocalizations.of(context).text("UPDATE")),
        ),
      ],
    );
  }

  Widget formField(
      int index,
      String hint,
      ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
                color: Colors.grey, width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  //focusNode: fnode7,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: AppData.hintColor, fontSize: 15),
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
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
                color: Colors.grey, width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  //focusNode: fnode7,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp("[0-9 .]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: AppData.hintColor, fontSize: 15),
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
                             _height.text=value;
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
                        decoration:
                        InputDecoration(hintText: "BMI(KG/m)"),
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
                        decoration:
                        InputDecoration(hintText: "Temprature"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                          // valueText = value;
                           _systolicbloodpressure.text = value;
                          });
                        },
                        controller: _systolicbloodpressure,
                        decoration:
                        InputDecoration(hintText: "Systolic Blood Pressure"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                           //valueText = value;
                           _diastolicbloodpressure.text = value;

                          });
                        },
                        controller: _diastolicbloodpressure,
                        decoration: InputDecoration(hintText: "Diastolic Blood Pressure"),
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
                        decoration:
                        InputDecoration(hintText: " Pulse"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                           // valueText = value;
                           _respiration.text = value;
                          });
                        },
                        controller: _respiration,
                        decoration:
                        InputDecoration(hintText: " Respiration"),
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
                child: Text('CANCEL', style: TextStyle(color: Color(0xFF2372B6))),
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
                  setState(() {

                  });
                },
              ),
            ],
          );
        });
  }

}


