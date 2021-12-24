import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/OpdModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class MyOpdPage extends StatefulWidget {
  final MainModel model;

  const MyOpdPage({Key key, this.model}) : super(key: key);

  @override
  _MyOpdPageState createState() => _MyOpdPageState();
}

class _MyOpdPageState extends State<MyOpdPage> {
  OpdModel opdModel;
  LoginResponse1 loginResponse1;
  SharedPref sharedPref = SharedPref();
  bool _value = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedStartTime;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.OPD_MODEL + loginResponse1.body.user,
        fun: (Map<String, dynamic> map) {
          log("Json Response>>>" + jsonEncode(map));

          if (map["code"] == "success") {
            setState(() {
              log("Json Response>>>" + JsonEncoder().convert(map));
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                opdModel = OpdModel.fromJson(map);
              } else {
                AppData.showInSnackBar(context, map[msg]);
              }
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My OPD"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: (opdModel != null) ? _dataTable() : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataTable _dataTable() {
    return DataTable(
      onSelectAll: (b) {},
      //dataRowHeight: 3,
      columnSpacing: 3,
      horizontalMargin: 6,
      headingRowHeight: 50,
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black),
      // sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Container(
            width: 80.0,
            //color: Colors.red,
            child: Text(
              'DATE',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Container(
            width: 90.0,
            //color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              "DAYS",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          numeric: false,
          //tooltip: "Description",
        ),
        DataColumn(
          label: Container(
            width: 90.0,
            child: Text(
              "ON/OFF",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Container(
            width: 90.0,
            child: Text(
              "FROM TIME",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Container(
            width: 90.0,
            child: Text(
              "TO TIME",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Container(
            width: 90.0,
            child: Text(
              "REMARK",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: opdModel.body
          .asMap()
          .map((i, data) => MapEntry(
                i,
                DataRow(
                  // selected: true,
                  cells: [
                    DataCell(
                      InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       new MaterialPageRoute(
                        //           builder: (context) => SareeDetailsPage(
                        //             data: opdModel.body[i],
                        //             model: widget.model,
                        //           ))).then((value) {});
                        // },
                        child: Container(
                          width: 80.0,
                          child: Center(
                            child: Text(
                              data?.key ?? "",
                              style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Container(
                        width: 90.0,
                        child: Center(
                          child: Text(
                            data?.name ?? "",
                            style: TextStyle(color: Colors.black),
                           textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                          width: 90.0,
                          child: Center(
                              child: _normalToggleButton(opdModel.body[i].code)
                          )
                          // Text(
                          //   data?.code ?? "",
                          //   style: TextStyle(color: Colors.black),
                          //   textAlign: TextAlign.center,
                          // ),
                          ),
                    ),
                    DataCell(
                      Container(
                        width: 90.0,
                        child: Center(
                          child:
                          //stTime()
                          Text(
                            data?.image ?? "",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 90.0,
                        child: Center(
                          child: Text(
                            data?.language ?? "",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 90.0,
                        child: Center(
                          child: Text(
                            data?.pass ?? "",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .values
          .toList(),
    );
  }

  Widget _normalToggleButton(bool code) {
    return Container(
      child: Transform.scale(
        scale: 1,
        child: Switch(
          //activeColor: Colors.pinkAccent,
          activeTrackColor: AppData.kPrimaryColor,
          // inactiveTrackColor: Colors.pinkAccent,
          //inactiveThumbColor: Colors.green,
          value: code,
          // activeThumbImage: AssetImage("assets/man.png",),
          //inactiveThumbImage: AssetImage("assets/women.png"),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (bool value) {
            print("VALUE : $value");
            setState(() {
              code=_value;
             // data?.code
             // _value = value;
              //_value = opdModel.body[i].code;

              // if(value==false) {
              //   widget.model.patientgender = "2";
              // }else{
              //   widget.model.patientgender = "1";
              //
              // }
            });
          },
        ),
      ),
    );
  }

  Widget stTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectTime(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              enabled: false,
             // controller: stime,
              // textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                // prefixIcon: Icon(
                //   Icons.calendar_today,
                //   size: 18,
                //   color: AppData.kPrimaryColor,
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        selectedStartTime = timeOfDay;
       // stime.text = formatTimeOfDay(timeOfDay);
      });
    }
  }



}
