import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/DocterMedicationlistModel.dart';

import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/MedicationlistModel.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:user/widgets/text_field_address.dart';
import 'package:user/widgets/text_field_container.dart';

class Medicationlist extends StatefulWidget {
  MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  Medicationlist({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _MedicationlistState createState() => _MedicationlistState();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicationlistState extends State<Medicationlist> {
  DateTime selectedDate = DateTime.now();
  MedicationlistModel medicationlistModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String useridst;
  bool isdata =true;
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();

  /* List<KeyvalueModel> lists = [
    KeyvalueModel(),
    KeyvalueModel(),
  ];*/
  List<MedicinlistModel> medicinlist = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      useridst = widget.model.appointmentlist.userid;
      //toThis_.text = df.format(date);
      //callAPI(selectedDatestr);
      callAPI();
    });
  }

  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox = false;
  String _checkboxstr = "0";
  String _checkboxstr1 = "0";
  String _checkboxstr2 = "0";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
        /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        //callAPI();
      });
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.VIEW_USER_MEDICINE_DETAILS +
            widget.model.appointmentlist.doctorName /*"4"*/,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map["code"] == Const.SUCCESS) {
              setState(() {
                isdata =false;
                medicationlistModel = MedicationlistModel.fromJson(map);
              });
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              isdata =false;
              // isDataNotAvail = true;
             // AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: MyWidgets.appBar(context),
      body: SafeArea(
        //height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                child: Card(
                  elevation: 1,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(MyLocalizations.of(context).text("ADD_MEDICINE"),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //Spacer(),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialogaddnomination(context),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.add_box,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
          SingleChildScrollView(
            child: isdata == true
                ? Center(
                  child: Column(
                    children: [
                      SizedBox(height:  MediaQuery.of(context).size.height* 0.35,),
                      CircularProgressIndicator(
               ),
                    ],
                  ),
                )
                : medicationlistModel == null || medicationlistModel == null
                ? Container(
              child: Center(
                child: Image.asset("assets/NoRecordFound.png",
                                          // height: 25,
                                        ),
              ),

            ) :(medicationlistModel != null)
                  ? ListView.separated(
                      separatorBuilder: (context, i) {
                        return Divider();
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medicationlistModel.body.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Body medicationlis = medicationlistModel.body[index];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(bottom: 10),
                                  /*decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(
                                                8)),*/
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (index + 1).toString() +
                                              ". " +
                                              medicationlis.medname +
                                              "(${medicationlis.medtype})" +
                                              "(" +
                                              medicationlis.duration +
                                              " Days)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        /*  Text(
                                          "Duration:" +
                                              medicationlis.duration +
                                              " Days",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(),
                                        ),*/

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Morning",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (medicationlis.morning == "1")
                                                    ? Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  //width: 80,
                                                  child: Text(
                                                    "Afternoon",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (medicationlis.afternoon == "1")
                                                    ? Container(
                                                        width: 100,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Night",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                (medicationlis.evening == "1")
                                                    ? Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 80,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons
                                                              .highlight_remove,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Notes: " + medicationlis.remarks ??
                                              "N/A",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      // itemCount:medicinmodel.length,
                    )
                  :Center(child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
              ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogaddnomination(BuildContext context) {
    DoctorMedicationlistModel item = DoctorMedicationlistModel();
    textEditingController[0].text = "";
    textEditingController[1].text = "";
    textEditingController[2].text = "";
    _checkbox = false;
    _checkbox1 = false;
    _checkbox2 = false;
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(MyLocalizations.of(context).text("ADD_MEDICINE")),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: SizedBox(
                    height: 58,
                    child: DropDown.networkDropdownGetpartUser(
                        MyLocalizations.of(context).text("MEDICINE"),
                        ApiFactory.MEDICINE_API,
                        "medicine",
                        Icons.fiber_manual_record,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.MEDICINE_API);
                        Medicationlist.medicinModel = data;
                        textEditingController[0].text =
                            Medicationlist.medicinModel.code;

                        /* userModel.country=data.key;
                                                    userModel.countryCode=data.code;*/
                      });
                    }),
                  ),
                ),
                fromField1(0, MyLocalizations.of(context).text("TYPE"),
                    TextInputAction.next, TextInputType.text,
                    "Type"),

                //formFieldMobile(1,"Day Duration"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyLocalizations.of(context).text("MORNING"),
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        value: this._checkbox,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox = value;
                            /*if (value = true) {

                              _checkboxstr = "1";
                              //AppData.showInSnackBar(context,_checkboxstr );
                            }else{
                              _checkboxstr = "0";
                            }*/
                          });
                        },
                      ),
                      /* Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        value: this._checkbox,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox = value;
                            if (_checkbox = true) {
                              _checkboxstr = "1";
                              // AppData.showInSnackBar(context,_checkboxstr );
                            }
                          });
                        },
                      ),*/
                    ],
                  ),
                ),
                //Divider(height: 2,color: Colors.black),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyLocalizations.of(context).text("AFTERNOON"),
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        value: this._checkbox1,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox1 = value;
                            /*if (value = true) {
                              _checkboxstr1 = "1";
                            }else{
                              _checkboxstr1 = "0";
                            }*/
                          });
                        },
                      ),
                    ],
                  ),
                ),

                //Divider(height: 2,color: Colors.black),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyLocalizations.of(context).text("NIGHT"),
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        value: this._checkbox2,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox2 = value;
                            /*if (value = true) {
                              _checkboxstr2 = "1";
                            }else{
                              _checkboxstr2 = "0";
                            }*/
                          });
                        },
                      ),
                    ],
                  ),
                ),
                fromfild(1, MyLocalizations.of(context).text("DURATION_DAYS"),TextInputAction.next,
                    TextInputType.text, "duration"),
                fromAddress(2, MyLocalizations.of(context).text("REMARK"), TextInputAction.next,
                    TextInputType.text, "remark"),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            textEditingController[0].text = "";
            textEditingController[1].text = "";
            textEditingController[2].text = "";
          },
          textColor: AppData.kPrimaryRedColor,
          child: Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          onPressed: () {
            if (Medicationlist.medicinModel == null ||
                Medicationlist.medicinModel == "") {
              AppData.showInSnackBar(context, "Please select item name");
              /* } else if (textEditingController[1].text == '') {
              AppData.showInSnackBar(context, "Please enter Day Duration");*/
            } else if (_checkbox == false &&
                _checkbox1 == false &&
                _checkbox2 == false) {
              AppData.showInSnackBar(
                  context, "Please checked terms and Condition");
            } else if (textEditingController[2].text == '') {
              AppData.showInSnackBar(context, "Please enter remark");
            } else {
              //NomineeModel nomineeModel = NomineeModel();
              item.userid = widget.model.appointmentlist.userid;
              item.appno = widget.model.appointmentlist.doctorName; //appno
              //item.mednaid = Medicationlist.medicinModel.key;
              item.medname = Medicationlist.medicinModel.key;
              item.duration = textEditingController[1].text;
              item.remarks = textEditingController[2].text;
              item.doctor = widget.model.user;
              //item.morning = _checkboxstr.toString();
              item.morning = (_checkbox==true)?"1":"0";
              item.afternoon = /*_checkboxstr1.toString();*/(_checkbox1==true)?"1":"0";
              item.evening = /*_checkboxstr2.toString()*/(_checkbox2==true)?"1":"0";
              print("API NAME>>>>" + ApiFactory.POST_MEDICATION);
              print("TO POST>>>>" + jsonEncode(item.toJson()));
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.POST_MEDICATION,
                  json: item.toJson(),
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                      callAPI();
                      //popup(context, "Medicine Added Successfully",map[Const.BODY]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
              //nomineeModel.relaion = AddEmployeePage.RelationModel.key;

              /*setState(() {
                medicinlist.add(item);
              });*/
            }
            Navigator.of(context).pop();
            /*controller[0].text="";
             controller[1].text="";*/
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(MyLocalizations.of(context).text("SAVE")),
        ),
      ],
    );
  }

  /* DataTable _dataTable() {
    */ /*MaterialStateProperty<Colors> material=[
      Colors.red
    ];*/
  /*
    return DataTable(
      columns: [
        DataColumn(
          label:Container(
            //color: Colors.red,
            width: 130,
            child: Center(
              child: Text(
                'Medication Name',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ),
        DataColumn(
          label: Text("Age"),
        ),
        DataColumn(
          label: Text("Year"),
        ),
        DataColumn(
          label: Text("Year"),
        ),
        //DataColumn(label: FlutterLogo())
      ],
      rows: lists.map((data) {
        return DataRow(cells: [
          DataCell(Text("cvbvbn")),
          DataCell(Text("sdfgh")),
          DataCell(Text("dfgh")),
          DataCell(FlutterLogo())
        ]);
      }).toList(),
    );

    */ /*DataTable(
        onSelectAll: (b) {},
        //dataRowHeight: 3,
        columnSpacing: 6,
        horizontalMargin: 5,
        headingRowHeight: 40,
        headingRowColor:
        MaterialStateColor.resolveWith((states) => AppData.greyBorder),
        // sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          */ /**/ /*DataColumn(
            label: Container(
              //color: Colors.red,
              child: Text(
                'Emp id',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),*/ /**/
  /*
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: 100,
              child: Center(
                child: Text(
                  'Medication Name',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: 80,
              child: Center(
                child: Text(
                  "M",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: 80,
              child: Center(
                child: Text(
                  "A",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: 80,
              child: Center(
                child: Text(
                  "N",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: 80,
              child: Center(
                child: Text(
                  "Action",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
        rows: itemModel
            .asMap()
            .map((i, data) => MapEntry(
          i,
          DataRow(
            // selected: true,
            cells: [

              */ /**/ /*DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child: Text(data.itemno,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // showEditIcon: true,
                // placeholder: true,
              ),*/ /**/ /*
              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child: Text(*/ /**/ /*data.medname*/ /**/ /*"name",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),

              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child:Text(*/ /**/ /*data.medname*/ /**/ /*"name",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,),
                  ),
                ),
              ),
              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child:Text(*/ /**/ /*data.medname*/ /**/ /*"name",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,),
                  ),
                ),
              ),

              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          itemModel.remove(data);
                        });
                      },
                      child: Icon(
                        Icons.remove_circle,
                        // color: Colors.red,
                      ),
                    )
                  ],
                ),
                showEditIcon: false,
                placeholder: false,
              ),
            ],
          ),
        ))

            .values
            .toList());*/
  /*


  }*/
  Widget fromField1(int index, String hint, inputAct, keyType, String type) {
    return TextFieldContainer(
      child: AbsorbPointer(
        child: TextFormField(
          controller: textEditingController[index],
          textInputAction: inputAct,
          /*inputFormatters: [
            //UpperCaseTextFormatter(),
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],*/
          keyboardType: keyType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            // suffixIcon: Icon(Icons.person_rounded),
            //contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),
          /* decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),

            // suffixIcon: Icon(Icons.person_rounded),
            //contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),*/
          textAlignVertical: TextAlignVertical.center,
          onChanged: (newValue) {},
          /*onFieldSubmitted: (value) {
            print("ValueValue" + error[index].toString());
            setState(() {
              error[index] = false;
            });
            AppData.fieldFocusChange(context, currentfn, nextFn);
          },*/
        ),
      ),
    );
  }

  Widget fromAddress(int index, String hint, inputAct, keyType, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        //focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          // suffixIcon: Icon(Icons.person_rounded),
          //contentPadding: EdgeInsets.symmetric(vertical: 10)
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {},
        onFieldSubmitted: (value) {
          /* print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });*/

          /// AppData.fieldFocusChange(context, currentfn, nextFn);
        },
      ),
    );
  }

  Widget fromfild(int index, String hint, inputAct, keyType, String type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            controller: textEditingController[index],
            //focusNode: currentfn,
            textInputAction: inputAct,
            maxLength: 3,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[0-9]")),
            ],

            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),

              // suffixIcon: Icon(Icons.person_rounded),
              //contentPadding: EdgeInsets.symmetric(vertical: 10)
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: (newValue) {},
            onFieldSubmitted: (value) {
              /* print("ValueValue" + error[index].toString());
              setState(() {
                error[index] = false;
              });*/

              /// AppData.fieldFocusChange(context, currentfn, nextFn);
            },
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
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
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
                  /* inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],*/
                  keyboardType: TextInputType.number,
                  /* inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp("[0-9 ]")),
                  ],*/
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
                    // error[4] = false;
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

  /*Widget changeStatus(BuildContext context, String patname, String doctorName) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 20),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "CHANGE STATUS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  */ /*"Lisa Rani"*/ /*
                  patname,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("Confirmed"),
                  leading: Icon(Icons.book),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "2",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);
                              Navigator.of(context).pop();
                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
                    //updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("Cancelled"),
                  leading: Icon(Icons.trending_up),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "4",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);
                              Navigator.of(context).pop();
                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
                    //updateApi(userName.id.toString(), "1", i);
                  },
                ),
                */ /*Divider(
                  height: 2,
                ),*/ /*
                */ /* ListTile(
                  title: Text("COMPLETED"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
//                    updateApi(userName.id.toString(), "2", i);
                  },
                )*/ /*
              ],
            ),
          );
        },
      ),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("CANCEL"),
        ),
      ],
    );
  }*/

  Widget appointdate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Expanded(
        child: InkWell(
          onTap: () {
            print("Click done");
            _selectDate(context);
          },
          child: AbsorbPointer(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                autofocus: false,
                controller: fromThis_,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'From this',
                  //labelText: 'Booking Date',
                  alignLabelWithHint: false,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "Add".toUpperCase(),
      context: context,
      fun: () {
        /*  medicinlist.item_details = itemModel;
        print(medicinlist.toString());*/
        //signupModel.image_path = position.longitude.toString();
        //MyWidgets.showLoading(context);
        /*widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.POST_MEDICATION,
        json: medicinlist.toJson(),
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, "Medicine Added Successfully",map[Const.BODY]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
      },
    );
  }

  popup(BuildContext context, String message, String body) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              /* Navigator.pop(context);
              Navigator.pop(context);*/
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
}
