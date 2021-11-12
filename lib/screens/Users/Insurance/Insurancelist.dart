import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/InsuranceModel.dart'as insurance;
import 'package:user/models/InsurancePostModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class InsuranceList extends StatefulWidget {
  MainModel model;

  InsuranceList({Key key, this.model}) : super(key: key);

  @override
  _InsuranceListState createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {
  var selectedMinValue;
  LoginResponse1 loginResponse1;
  insurance. InsuranceModel insuranceModel;

  DateTime selectedDate = DateTime.now();
  String selectDob;
  TextEditingController _startdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _premiumdate = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  final df = new DateFormat('dd/MM/yyyy');

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
    new TextEditingController(),
    new TextEditingController(),
  ];
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();
  FocusNode fnode10 = new FocusNode();
  FocusNode fnode11 = new FocusNode();
  FocusNode fnode12= new FocusNode();
  FocusNode fnode13= new FocusNode();
  FocusNode fnode14= new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }
  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.INSURANCE_list + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                insuranceModel = insurance.InsuranceModel.fromJson(map);
              });
            } else {
              setState(() {
               // isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Insurance"),
          centerTitle: true,
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
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (insuranceModel !=null) ?ListView.builder(
               itemCount: insuranceModel.body.length,
               // itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  insurance.Body body = insuranceModel.body[i];
                  String insuranceid=body.key;
                  widget.model.insuranceid=insuranceid;
                  return
                    InkWell(
                      onTap: () {
                widget.model.insuranceid=body.key;
                Navigator.pushNamed(context, "/insuranceDetalis");

                },

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    shadowColor: Colors.grey,
                    elevation: 10,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Container(
                          decoration: (i % 2 == 0)
                              ? BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppData.kPrimaryRedColor,
                                      width: 5)))
                              : BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppData.kPrimaryColor,
                                      width: 5))),
                          width: double.maxFinite,
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        body.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        body.code,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Premium Amount',
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                Image.asset(
                                  "assets/forwardarrow.png",
                                  fit: BoxFit.fitWidth,
                                  /*width: 50,*/
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                      ),

                    ),
                  ),
                );
                },
                  ):Container(),
          ],
        ),
      ),
    );
  }

  Widget dialogaddnomination(BuildContext context) {
    textEditingController[1].text = "";
    textEditingController[2].text = "";
    textEditingController[3].text = "";
    _startdate.text="";
    textEditingController[5].text = "";
    _enddate.text="";
    textEditingController[7].text = "";
    textEditingController[8].text = "";
    textEditingController[9].text = "";
    _premiumdate.text="";
    textEditingController[11].text = "";
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

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("ADD INSURANCE",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        formField(1,"Insurance Company"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(2,"Health Insurance Type"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(3,"Policy No"),
                        SizedBox(
                          height: 8,
                        ),
                        startdate(),
                       // formField(4,"Policy Start Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(5,"Total Insurance Amount"),
                        SizedBox(
                          height: 8,
                        ),
                        premiumDate(),
                      //  formField(6,"Premium Due Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(7,"Insurance Type"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(8,"Third Party Adminstrator"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(9,"Premium Amount"),
                        SizedBox(
                          height: 8,
                        ),
                        policyendDate(),
                        //formField(10,"Policy End Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(11,"Sum Assured Amount"),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),

                  // fromAddress(0, "Remark", TextInputAction.next,
                  //     TextInputType.text, "remark"),
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
            textEditingController[1].text = "";
            textEditingController[2].text = "";
            textEditingController[3].text = "";
            _startdate.text="";
            textEditingController[5].text = "";
            _enddate.text="";
            textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            _premiumdate.text="";
            textEditingController[11].text = "";

            // textEditingController[0].text = "";
          },
          child:Text("CANCEL",
            style: TextStyle(color: AppData.matruColor),
          ),
        ),
        new FlatButton(
        child: Text(
        'SAVE',
    style: TextStyle(color: AppData.matruColor),
    ),
          onPressed: () {
            if (textEditingController[1].text == null ||
                textEditingController[1].text == "") {
              AppData.showInSnackBar(context, "Please Enter Insurance Company Name ");
            } else if (textEditingController[2].text == null ||
                textEditingController[2].text == "") {
              AppData.showInSnackBar(context, "Please Enter Health Insurance Type");
            } else if (textEditingController[3].text == null ||
                textEditingController[3].text == "") {
              AppData.showInSnackBar(context, "Please Enter Policy No ");
            }
            else if (_startdate.text == "" ||
                _startdate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Policy Start Date");
            }
            else if (textEditingController[5].text == "" ||
                textEditingController[5].text == null) {
              AppData.showInSnackBar(context, "Please Enter Total Insurance Amount");
            }
            else if (_premiumdate.text == "" ||
                _premiumdate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Premium Due Date");
            }
            else if (textEditingController[7].text == "" ||
                textEditingController[7].text == null) {
              AppData.showInSnackBar(context, "Please Enter Insurance Type");
            }
            else if (textEditingController[8].text == "" ||
                textEditingController[8].text == null) {
              AppData.showInSnackBar(context, "Please Enter Third Party Adminstrator");
            }
            else if (textEditingController[9].text == "" ||
                textEditingController[9].text == null) {
              AppData.showInSnackBar(context, "Please Enter Premium Amount");
            }
            else if (_enddate.text == "" ||
                _enddate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Policy End  Date");
            }
            else if (textEditingController[11].text == "" ||
                textEditingController[11].text == null) {
              AppData.showInSnackBar(context, "Please Enter Sum Assured Amount");
            }
            else {
              MyWidgets.showLoading(context);
              InsurancePostModel insurancepostmodel  = InsurancePostModel();
              insurancepostmodel.patientId = loginResponse1.body.user;
              insurancepostmodel.insCompany = textEditingController[1].text;
              insurancepostmodel.healthInsType = textEditingController[2].text;
              insurancepostmodel.policyNo =textEditingController[3].text;
              insurancepostmodel.policyStartDt =_startdate.text;
              insurancepostmodel.totalInsAmount = textEditingController[5].text;
              insurancepostmodel.premiumDueDt = _premiumdate.text;
              insurancepostmodel.insType = textEditingController[7].text;
              insurancepostmodel.thirdPartyAdm = textEditingController[8].text;
              insurancepostmodel.premiumAmount = textEditingController[9].text;
              insurancepostmodel.policyEndDt = _enddate.text;
              insurancepostmodel.sumAssuredAmt = textEditingController[11].text;
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                  insurancepostmodel.toJson().toString());
              widget.model.POSTMETHOD2(
                api: ApiFactory.INSURANCE_POST,
                json: insurancepostmodel.toJson(),
                token: widget.model.token,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  setState(() {
                    if (map[Const.STATUS1] == Const.SUCCESS) {
                      callApi();
                      AppData.showInSnackDone(
                          context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
                },
              );
              //AppData.showInSnackBar(context, "add Successfully");
            }

            // Navigator.of(context).pop();
            // AllergicListList.nameModel.key="";
            // AllergicListList.typeModel.key="";
            // AllergicListList.severitylistModel.key="";
            // textEditingController[1].text="";
            // textEditingController[2].text="";
          },
        ),
      ],
    );
  }

  Widget formField(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
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
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          /*inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z 1-10 ]")),
          ],*/
        ),
      ),
    );
  }
Widget formField1(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
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
          keyboardType: TextInputType.number,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  Widget policyendDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _endDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _enddate,
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
                hintText:("Policy End Date"),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color:Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget premiumDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _premiumDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _premiumdate,
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
                hintText:("Premium Due Date"),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color:Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget startdate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _startDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _startdate,
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
                hintText:("Policy Start Date"),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color:Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<Null> _startDate(BuildContext context) async {
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
        _startdate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }
  Future<Null> _endDate(BuildContext context) async {
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
        _enddate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }
  Future<Null> _premiumDate(BuildContext context) async {
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
        _premiumdate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

}
