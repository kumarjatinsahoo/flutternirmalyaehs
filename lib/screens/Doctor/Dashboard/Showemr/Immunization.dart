import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/ImmunizationListModel.dart'as immunization;
import 'package:user/models/ImmunizationPostModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/widgets/MyWidget.dart';

class Immunization extends StatefulWidget {
  MainModel model;
  static KeyvalueModel immunizationmodel = null;


  Immunization({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Immunization();
}
enum TypeDob { No, Yes }
class _Immunization extends State<Immunization> {
  FocusNode _descriptionFocus, _focusNode;
  String eHealthCardno;
  immunization.ImmunizationListModel immunizationListModel;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String selectDob;


  TextEditingController _date = TextEditingController();

  //TextEditingController _reason = TextEditingController();
  TextEditingController _name = TextEditingController();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  AddBioMedicalModel addBioMedicalModel = AddBioMedicalModel();
  TypeDob selectDobEn = TypeDob.No;
  String _selectedGender = 'No';

  @override
  void initState() {
    super.initState();
    eHealthCardno = widget.model.patientseHealthCard;
    callApi(eHealthCardno);
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
  }

  callApi(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IMMUNIZATION_LIST + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              setState(() {
                immunizationListModel =
                    immunization.ImmunizationListModel.fromJson(map);
              });
            } else {
              setState(() {
               // isdata = false;
                //isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  displayStatushangeDialog(BuildContext context ,String slno, String status
      ) {

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Positioned(
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Colors.red,size: 25,),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Are you Vaccinated ?",
                          style: TextStyle(
                              color: Colors.black, fontSize: 25,fontWeight: FontWeight.w400, // light
                              fontStyle: FontStyle.normal ),
                        ),
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text("No",
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  widget.model.GETMETHODCALL_TOKEN(
                      api: ApiFactory
                          .IMMUNIZATION_STATUS + slno +
                          "&status=" + /*status*/"No",
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        setState(() {
                          log("Value>>>" +
                              jsonEncode(map));
                          String msg = map[Const.MESSAGE];
                          if (map[Const.CODE] ==
                              Const.SUCCESS) {
                            setState(() {
                              callApi(eHealthCardno);
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              //isDataNoFound = true;
                            });
                            //AppData.showInSnackBar(context, msg);
                          }
                        });
                      });
                  /*setState(() {
                    Navigator.pop(context);
                  });*/
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  "Yes",
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  widget.model.GETMETHODCALL_TOKEN(
                      api: ApiFactory
                          .IMMUNIZATION_STATUS + slno +
                          "&status=" + /*status*/"yes",
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        setState(() {
                          log("Value>>>" +
                              jsonEncode(map));
                          String msg = map[Const.MESSAGE];
                          if (map[Const.CODE] ==
                              Const.SUCCESS) {
                            setState(() {
                              callApi(eHealthCardno);
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              //isDataNoFound = true;
                            });
                            //AppData.showInSnackBar(context, msg);
                          }
                        });
                      });

                },
              ),
            ],
          );
        },
        context: context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      body:
      isdata == true
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(),
          ],
        ),
      )
      /* Center(
                child: CircularProgressIndicator(),
              )*/
          : immunizationListModel == null || immunizationListModel == null
          ? Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Text(
                "Data Not Found",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      )
          :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text(
                      "Immunization",
                      style: TextStyle(
                          color:AppData.kPrimaryBlueColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        displayTextInputDialog(context);
                      },
                      child: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 26.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: (immunizationListModel != null)
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.horizontal,
                  /* itemCount: 2,
                itemBuilder: (BuildContext context, int index) {*/
                  itemBuilder: (context, i) {
                    immunization.Body immunizations = immunizationListModel.body[i];
                    return InkWell(
                    onTap: () {
                    String slno = immunizations.slno;
                    String status = immunizations.status;
                    displayStatushangeDialog(context,slno,status);
                    },
                    child:Card(
                      color: Color(0xFFD2E4FC),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          side: BorderSide(width: 1, color: Color(0xFFD2E4FC))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Immunization",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Expanded(
                               child:
                               Container(
                                  width: 200,
                                  child: Text(
                                    immunizations.immunizationId,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Prescribed",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  immunizations.doctorName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Date",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  immunizations.immunizationDate,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  immunizations.status,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    );
                  },
                  itemCount: immunizationListModel.body.length,
                ) : Container(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  displayTextInputDialog(BuildContext context) {
    // = "";
    //_reason.text = "";
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text("Add Immunization",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // DropDown.networkDropdownGet(
                        //     "Name", ApiFactory.ADM_EQUIPMENT_API, "admequipment",
                        //     (KeyvalueModel model) {
                        //   setState(() {
                        //     print(ApiFactory.ADM_EQUIPMENT_API);
                        //     BiomediImplants.admequipmentmodel = model;
                        //   });
                        // }),

                        DropDown.networkDropdownGetpartUser1("Immunization Type",
                            ApiFactory.IMMUNIZATION_API,
                            "immunization",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.IMMUNIZATION_API);
                                Immunization.immunizationmodel = data;
                              });
                            }),
                        SizedBox(height: 8),
                        dob(),
                        SizedBox(height: 8),
                        formField(1,"Prescribed By"),
                        SizedBox(height: 8),
                        formField(2,"Immunization Details"),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Status: "),
                          ),
                        ),

                        SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child:ListTile(
                                leading: Radio(
                                  value: 'No',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ),
                                title: Text('No'),
                              ),


                            ),
                            Expanded(

                              child: ListTile(
                                leading: Radio(
                                  value: 'Yes',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ),
                                title: Text('Yes'),
                              ),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text("Cancel",
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text("Submit",
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  if (Immunization.immunizationmodel == null ||
                      Immunization.immunizationmodel == "") {
                    AppData.showInSnackBar(
                        context, "Please Select Immunization Type ");
                  } else if (_date.text == "" || _date.text == null) {
                    AppData.showInSnackBar(context, "Please Enter Date");
                  } else if (textEditingController[1].text == "" ||
                      textEditingController[1].text == null) {
                    AppData.showInSnackBar(
                        context, "Please Enter Prescribed By");
                  } else if (textEditingController[2].text == "" ||
                      textEditingController[2].text == null) {
                    AppData.showInSnackBar(
                        context, "Please Enter Immunization Details ");
                  } else {
                    MyWidgets.showLoading(context);
                    ImmunizationPostModel immunizationmodel =
                    ImmunizationPostModel();
                    immunizationmodel.patientId = eHealthCardno;
                    immunizationmodel.immunizationId =
                        Immunization.immunizationmodel.key;
                    immunizationmodel.immunizationDate = _date.text;
                    immunizationmodel.doctorName =
                        textEditingController[1].text;
                    immunizationmodel.immunizationDetails =
                        textEditingController[2].text;
                    immunizationmodel.status = _selectedGender;
                    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                        immunizationmodel.toJson().toString());
                    widget.model.POSTMETHOD2(
                      api: ApiFactory.ADD_IMMUNIZATION,
                      json: immunizationmodel.toJson(),
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        Navigator.pop(context);
                          if (map["code"] == Const.SUCCESS) {
                            Navigator.pop(context);
                            AppData.showInSnackDone(context, map[Const.MESSAGE]);
                            callApi(eHealthCardno);
                          } else {
                            callApi(eHealthCardno);
                            //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
        context: context);
  }

  Widget dob() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _date,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              onSaved: (value) {
                //userPersonalForm.dob = value;
                selectDob = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  error[2] = true;
                  return null;
                }
                error[2] = false;
                return null;
              },
              onFieldSubmitted: (value) {
                error[2] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                AppData.fieldFocusChange(context, fnode3, fnode4);
              },
              decoration: InputDecoration(
                hintText: ("Immunization Date"),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate:
        DateTime.now().add(new Duration(days: 5))); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _date.value = TextEditingValue(text: df.format(picked));
        addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

  Widget formField(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          // controller: _reason,
          controller:textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

}

