import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';

import 'package:user/models/MedicinModel.dart';
import 'package:user/models/UserListModel.dart';

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

class DoctorTestlist extends StatefulWidget {
  MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  DoctorTestlist({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _DoctorTestlistState createState() => _DoctorTestlistState();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _DoctorTestlistState extends State<DoctorTestlist> {
  DateTime selectedDate = DateTime.now();
  UserListModel userListModel;
  bool isdata = true;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String useridst;
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
        api: ApiFactory.doctor_TEST_LIST +
            widget.model.appointmentlist.doctorName /*"4"*/,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map["code"] == Const.SUCCESS) {
              setState(() {
                isdata = false;
                userListModel = UserListModel.fromJson(map);
              });
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              isdata = false;
              // isDataNotAvail = true;
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: double.maxFinite,
          child: Column(
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
                        child: Text(MyLocalizations.of(context).text("ADD_TEST"),
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
              /* Container(
            height: 50,
            child: Card(
              elevation: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 4),
                    child:
                    Text("Add Test",style: TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.bold),)

                    */ /*MyWidgets.header(
                        "  Add Test", Alignment.centerLeft,),*/ /*
                    //child: MyWidgets.header("Attendance", Alignment.topLeft),
                  ),
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

                        // color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/

              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*isdata == true
                    ? CircularProgressIndicator(
                  backgroundColor: AppData.matruColor,
                )
                    : userListModel == null || userListModel == null
                    ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Data Found',
                           textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Colors.black, fontSize: 15,),
                        ),
                      ],
                    ),
                  ),
                ):*/
                    isdata == true
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                ),
                                CircularProgressIndicator(
                                    // backgroundColor: AppData.matruColor,
                                    ),
                              ],
                            ),
                          )
                        : userListModel == null || userListModel == null
                            ? Center(
                                child: Container(
                                  //height:  MediaQuery.of(context).size.height* 0.30,

                                  child: Column(
                                    children: [
                                      // SizedBox(
                                      //   height:
                                      //       MediaQuery.of(context).size.height *
                                      //           0.35,
                                      // ),
                                      Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                                    ],
                                  ),
                                ),
                              )
                            : (userListModel != null)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: userListModel.body.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      Body medicationlis =
                                          userListModel.body[index];

                                      return /*Dismissible(*/
                                        //key: Key(item1),
                                       /* key: Key(
                                            userListModel.body[index].toString()),
                                        direction: DismissDirection.startToEnd,*/
                                         Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5.0,
                                                right: 5.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Card(
                                                    elevation: 5,
                                                    child: Container(
                                                        //height: 100,
                                                        width: double.maxFinite,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              color: Colors
                                                                  .grey[300],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    medicationlis
                                                                            .testname ??
                                                                        "N/A",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "Type: " +
                                                                            medicationlis
                                                                                .testgroup.toString() ??
                                                                        "N/A",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  Text(
                                                                    medicationlis
                                                                            .remarks ??
                                                                        "N/A",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                              new Spacer(),
                                                              /*Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              widget.model.GETMETHODCALL_TOKEN(
                                                                  api: ApiFactory.DELETE_TEST_LIST +
                                                                      widget.model.appointmentlist.doctorName
                                                                      "4"+"&srlone=" +medicationlis.srlNoOne +
                                                                      "&srltwo=" + medicationlis.srlNoTwo,
                                                                  token: widget.model.token,
                                                                  fun: (Map<String, dynamic> map) {
                                                                    String msg = map[Const.MESSAGE];
                                                                    if (map["status"] == "success") {
                                                                      setState(() {
                                                                        userListModel.body.removeAt(index);
                                                                        //medicationlis.remove(index);
                                                                        //AppData.showInSnackBar(context, "hii");
                                                                        //medicinlist.remove(medicinlist[index]);
                                                                        callAPI();
                                                                        //medicinlist.remove(index);

                                                                        //medicinlist.remove(medicinlist[index]);
                                                                      });
                                                                    }else {
                                                                      // isDataNotAvail = true;
                                                                      AppData.showInSnackBar(context, msg);
                                                                    }

                                                                    setState(() {
                                                                      String msg = map[Const.MESSAGE];
                                                                      if (map["status"] == "success") {
                                                                        setState(() {
                                                                          callAPI();
                                                                          medicinlist.remove(medicinlist[index]);
                                                                        });
                                                                        //
                                                                        //medicinlist.removeAt(index);
                                                                        //medicinlist.removeAt(index);
                                                                        //


                                                                      } else {
                                                                        // isDataNotAvail = true;
                                                                        AppData.showInSnackBar(context, msg);
                                                                      }
                                                                    });
                                                                  });
                                                              //DELETE_MEDICINE_LIST
                                                              medicinlist.remove(
                                                                  medicinlist[
                                                                      index]);
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            // color: Colors.red,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),*/
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                       /* onDismissed: (direction) {
                                          setState(() {
                                            userListModel.body.removeAt(index);
                                          });
                                        },*/
                                    /*  );*/
                                    },
                                    // itemCount:medicinmodel.length,
                                  )
                                : Container(),
                    /* Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Data Found',
                textAlign: TextAlign.center,
                style:
                TextStyle(color: Colors.black, fontSize: 15,),
              ),
            ],
          ),
          ),*/
                    /*  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:  _submitButton(),
                ),*/
                    SizedBox(
                      height: 16,
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

  Widget dialogaddnomination(BuildContext context) {
    textEditingController[0].text = "";
    textEditingController[1].text = "";
    textEditingController[2].text = "";

    /// DoctorMedicationlistModel item = DoctorMedicationlistModel();
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
                // Text(MyLocalizations.of(context).text("ADD_TEST")),
                Text(MyLocalizations.of(context).text("ADD_TEST")),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: SizedBox(
                    height: 58,
                    child: DropDown.networkDropdownGetpartUser(
                      MyLocalizations.of(context).text("TEST"),
                        ApiFactory.TESTNAME_LIST,
                        // "http://192.168.43.248:8062/nirmalyaRest/api/get-testname-list",
                        "test",
                        Icons.fiber_manual_record,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.MEDICINE_API);
                        DoctorTestlist.medicinModel = data;
                        textEditingController[0].text =
                            DoctorTestlist.medicinModel.key;
                        textEditingController[1].text =
                            DoctorTestlist.medicinModel.code;
                            print('Group __- ' + DoctorTestlist.medicinModel.groupId);

                        /* userModel.country=data.key;
                                                    userModel.countryCode=data.code;*/
                      });
                    }),
                  ),
                ),
                fromField1(0,MyLocalizations.of(context).text("TEST_GROUP"), TextInputAction.next,
                    TextInputType.text, "Type"),
                fromField1(1,MyLocalizations.of(context).text("TEST_NAME"), TextInputAction.next,
                    TextInputType.text, "Type"),
                fromAddress(2,MyLocalizations.of(context).text("REMARK"), TextInputAction.next,
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
          child:  Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          onPressed: () {
            if (DoctorTestlist.medicinModel == null ||
                DoctorTestlist.medicinModel == "") {
              AppData.showInSnackBar(context, "Please select item name");
              /* } else if (textEditingController[1].text == '') {
              AppData.showInSnackBar(context, "Please enter Day Duration");*/
            } else if (textEditingController[2].text == '') {
              AppData.showInSnackBar(context, "Please enter remark");
            } else {
              var param = [
                {
                  "userid": widget.model.appointmentlist.userid,
                  "appno": widget.model.appointmentlist.doctorName, //appno"4",
                  "remarks": textEditingController[2].text,
                  "doctor": widget.model.user,
                  "testgroup": DoctorTestlist.medicinModel.groupId,
                  "testname":DoctorTestlist.medicinModel.testNameId
                }
              ];

              print("TO POST>>>>" + jsonEncode(param));
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.POST_TEST,
                  // api: "http://192.168.43.248:8062/nirmalyaRest/api/post-user-test-by-doctor",
                  json: param,
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

    */
  /*DataTable(
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
          */ /**/
  /*DataColumn(
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

              */
  /**/ /*DataCell(
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
              WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
            ],

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
