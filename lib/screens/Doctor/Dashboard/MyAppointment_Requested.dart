
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
class MyAppointmentRequested extends StatefulWidget {

   MainModel model;
  MyAppointmentRequested({Key key, this.model}) : super(key: key);
  @override
  _MyAppointmentRequestedState createState() => _MyAppointmentRequestedState();
}

class _MyAppointmentRequestedState extends State<MyAppointmentRequested> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr =  df.format(date).toString();
      //toThis_.text = df.format(date);
      callAPI(selectedDatestr);
    });
  }
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
        selectedDatestr =  df.format(selectedDate).toString();
        callAPI(selectedDatestr);

      });
  }
  callAPI(String today) {
    /*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.USER_APPOINTMENT_LIST +widget.model.user+"&date="+today+"&status="+"7",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              doctorAppointmment=DoctorAppointmment.fromJson(map);
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
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                appointdate(),

                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        Body appointmentlist = doctorAppointmment.body[i];
                        /* itemCount: lists.length,
                itemBuilder: (context, index) {*/
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 5.0,),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Card(
                                    elevation: 5,
                                    child: Container(
                                        height: 120,
                                        //width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(appointmentlist.doctorName,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18),),
                                                    SizedBox(height: 5,),
                                                    Text(appointmentlist.speciality,
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(),),
                                                    SizedBox(height: 5,),
                                                    Text(
                                                      "Patient Notes:"+appointmentlist.notes,
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(),),
                                                  ],
                                                ),),
                                              /*new Spacer(),*/
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,),
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    GestureDetector(
                                                      child:  Text(/*'Confirmed'*/appointmentlist.status,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.green),),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) =>
                                                              changeStatus(
                                                                context,

                                                              ),
                                                        );
                                                      },
                                                    ),

                                                    SizedBox(height: 3,),
                                                    Text(/*'23-Nov-2020-11:30AM'*/appointmentlist.appdate+appointmentlist.apptime,
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(),),

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
                      }

                  ),
                ),
              ],
            ),
          ),


        )
    );
  }
  Widget changeStatus(BuildContext context,  ) {
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
                  "Lisa Rani",
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
                        api: ApiFactory.user_APPOINTMENT_status +widget.model.user+"&appstatus="+"7",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment=DoctorAppointmment.fromJson(map);
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
                  title: Text("Requested"),
                  leading: Icon(Icons.trending_up),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +widget.model.user+"&appstatus="+"7",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment=DoctorAppointmment.fromJson(map);
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
                  floatingLabelBehavior:
                  FloatingLabelBehavior.always,
                  hintText: 'From this',
                  //labelText: 'Booking Date',
                  alignLabelWithHint: false,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  contentPadding:
                  EdgeInsets.only(left: 10, top: 4, right: 4),
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
      ),);
  }
  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/
      
        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }

 // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
}