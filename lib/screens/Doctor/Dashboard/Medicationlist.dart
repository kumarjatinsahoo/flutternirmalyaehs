import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/models/DocterMedicationModel.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';
import 'package:user/widgets/text_field_container.dart';

class Medicationlist extends StatefulWidget {
  MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;
  Medicationlist({Key key, this.model,this.isConfirmPage}) : super(key: key);
  @override
  _MedicationlistState createState() =>
      _MedicationlistState();
}
List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicationlistState
    extends State<Medicationlist> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
 /* List<KeyvalueModel> lists = [
    KeyvalueModel(),
    KeyvalueModel(),
  ];*/
  List<MedicinlistModel> medicinlist = [

  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      //toThis_.text = df.format(date);
      //callAPI(selectedDatestr);
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
        //callAPI(selectedDatestr);
      });
  }

  /*callAPI(String today) {
    *//*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*//*
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.doctor_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "7",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              doctorAppointmment = DoctorAppointmment.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Card(
                elevation: 1,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, bottom: 4),
                      child: MyWidgets.header(
                          "  Add Medicine", Alignment.centerLeft),
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
                        padding:
                        const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.add_box,

                          // color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
           /* SingleChildScrollView(`              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: _dataTable(),
              ),
            ),*/
            /*(itemModel != null)?SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: _dataTable(),
              ),
            ): Container(),*/
            SizedBox(
              height: 16,
            ),


            /* appointdate(),*/
            (medicinlist != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medicinlist.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                       //Body medicinmodel = medicinmodel[i];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    elevation: 5,
                                    child: Container(
                                       /* height: 100,*/
                                        //width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      medicinlist[index].medname,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Duration:" +
                                                          medicinlist[index].duration+ "Days",
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(),
                                                    ),
                                                    Text(medicinlist[index].remarks,
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(),),
                                                    SizedBox(height: 5,),
                                                    medicinlist[index].morning=="1"?Text("Morning",
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(fontWeight:
                                                      FontWeight.bold,),):Container(),
                                                    SizedBox(height: 5,),
                                                     medicinlist[index].afternoon=="1"?Text("Afternoon",
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(fontWeight:
                                                      FontWeight.bold ),):Container(),
                                                    SizedBox(height: 5,),
                                                    medicinlist[index].evening=="1"?Text("Evening",
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(fontWeight:
                                                      FontWeight.bold ),):Container(),
                                                    SizedBox(height: 5,),
                                                     /*Text(
                                                      'Confirmed'
                                                       medicinlistModel[Index].remarks,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 15,
                                                          color:
                                                          Colors.green),
                                                    ),*/
                                                  ],
                                                ),
                                              ),
                                              new Spacer(),
                                              Padding(
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
                                                          medicinlist.remove(medicinlist[index]);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        // color: Colors.red,
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                     // itemCount:medicinmodel.length,
                    )
                  : Container(),
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
    ));
  }

  Widget dialogaddnomination(BuildContext context) {
    DoctorMedicationlistModel item = DoctorMedicationlistModel();
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
                Text("Add Medicine"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: SizedBox(
                    height: 58,
                    child: DropDown.networkDropdownGetpartUser(
                        "Medicine",
                        ApiFactory.MEDICINE_API,
                        "medicine",
                        Icons.fiber_manual_record,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.MEDICINE_API);
                        Medicationlist.medicinModel = data;
                        textEditingController[0].text =Medicationlist.medicinModel.code;

                        /* userModel.country=data.key;
                                                    userModel.countryCode=data.code;*/
                      });
                    }),
                  ),
                ),
                fromField1(0, "Type", TextInputAction.next,
                    TextInputType.text, "Type"),

                //formFieldMobile(1,"Day Duration"),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Morning: ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                  Checkbox(
                    value: this._checkbox,
                    onChanged: (bool value) {
                      setState(() {
                        this._checkbox = value;
                        if (value = true) {
                          _checkboxstr = "1";
                          //AppData.showInSnackBar(context,_checkboxstr );
                        }
                      });
                    },),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Afternoon ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        value: this._checkbox1,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox1 = value;
                            if (value = true) {
                              _checkboxstr1 = "1";
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                //Divider(height: 2,color: Colors.black),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Evening ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        value: this._checkbox2,
                        onChanged: (bool value) {
                          setState(() {
                            this._checkbox2 = value;
                            if (value = true) {
                              _checkboxstr2 = "1";
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                fromfild(1, "Duration",TextInputAction.next,
                    TextInputType.text,
                    "remark"),
                fromAddress(
                     2,
                    "Remark",
                    TextInputAction.next,
                    TextInputType.text,
                    "remark"),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            textEditingController[0].text="";
            textEditingController[1].text="";
            textEditingController[2].text="";
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            if (Medicationlist.medicinModel == null || Medicationlist.medicinModel == "") {
              AppData.showInSnackBar(context, "Please select item name");
           /* } else if (textEditingController[1].text == '') {
              AppData.showInSnackBar(context, "Please enter Day Duration");*/
            } else if (textEditingController[2].text == '') {
              AppData.showInSnackBar(context, "Please enter remark");
            } else {
              //NomineeModel nomineeModel = NomineeModel();
              item.userid = widget.model.appointmentlist.userid;
              item.appno = widget.model.appointmentlist.doctorName;
              //item.mednaid = Medicationlist.medicinModel.key;
              item.medname = Medicationlist.medicinModel.key;
              item.duration = textEditingController[1].text;
              item.remarks = textEditingController[2].text;
              item.doctor = widget.model.user;
              item.morning = _checkboxstr.toString();
              item.afternoon = _checkboxstr1.toString();
              item.evening = _checkboxstr2.toString();
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.POST_MEDICATION,
                  json: item.toJson(),
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
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
          child: const Text('Save'),
        ),
      ],
    );
  }
 /* DataTable _dataTable() {
    *//*MaterialStateProperty<Colors> material=[
      Colors.red
    ];*//*
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

    *//*DataTable(
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
          *//**//*DataColumn(
            label: Container(
              //color: Colors.red,
              child: Text(
                'Emp id',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),*//**//*
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

              *//**//*DataCell(
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
              ),*//**//*
              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child: Text(*//**//*data.medname*//**//*"name",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),

              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child:Text(*//**//*data.medname*//**//*"name",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,),
                  ),
                ),
              ),
              DataCell(
                Container(
                  width: 80,
                  child: Center(
                    child:Text(*//**//*data.medname*//**//*"name",
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
            .toList());*//*


  }*/
  Widget fromField1(int index, String hint, inputAct, keyType,

  String type) {
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
  Widget fromAddress(int index, String hint, inputAct, keyType,
       String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        //focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
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
  Widget fromfild(int index, String hint, inputAct, keyType,
      String type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
          color: AppData.white,
          borderRadius: BorderRadius.circular(5),
      border: Border.all(
      color: Colors.black,width: 0.3)
      ),
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
            controller: textEditingController[index],
            //focusNode: currentfn,
            textInputAction: inputAct,
             maxLength: 3,
             keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter(
                RegExp("[0-9 ]")),
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
      ),),
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
            border: Border.all(
                color: Colors.black, width: 0.3)
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
                    hintStyle: TextStyle(
                        color: AppData.hintColor, fontSize: 15),
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
  Widget changeStatus(BuildContext context, String patname, String doctorName) {
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
                  /*"Lisa Rani"*/
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
                /*Divider(
                  height: 2,
                ),*/
                /* ListTile(
                  title: Text("COMPLETED"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
//                    updateApi(userName.id.toString(), "2", i);
                  },
                )*/
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
  popup(BuildContext context, String message,String body) {
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
