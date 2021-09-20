import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/MedicationAddScreen.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentConfirmed extends StatefulWidget {
  MainModel model;

  DoctorAppointmentConfirmed({Key key, this.model}) : super(key: key);

  @override
  _DoctorAppointmentConfirmedState createState() =>
      _DoctorAppointmentConfirmedState();
}

class _DoctorAppointmentConfirmedState
    extends State<DoctorAppointmentConfirmed> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  bool _checkbox = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
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
        selectedDatestr = df.format(selectedDate).toString();
        callAPI(selectedDatestr);
      });
  }

  callAPI(String today) {
    /*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.doctor_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "2",
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            appointdate(),

            /*InkWell(
                     onTap: (){
                       _displayTextInputDialog(context);
                     },
                     child: Text("edit",style: TextStyle(fontSize: 30),)),*/
            /* Navigator.push(
                   context,
                   new MaterialPageRoute(
                       builder: (context) => new ShowEmr(model:widget.model)));*/

            Expanded(
              child: (doctorAppointmment != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        Body appointmentlist = doctorAppointmment.body[i];
                        /* itemCount: lists.length,
                itemBuilder: (context, index) {*/
                        return InkWell(
                          onTap: (){
                            widget.model.appointmentlist=appointmentlist;
                            //Navigator.pushNamed(context, "/medi");
                            Navigator.pushNamed(context, "/doctorMedicationTab");
                          },
                          child: Column(
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
                                          height: 100,
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
                                                        appointmentlist.patname,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      /*Text(appointmentlist.speciality,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(),),
                                                SizedBox(height: 5,),*/
                                                      Text(
                                                        "Patient Notes:" +
                                                            appointmentlist.notes,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                /*new Spacer(),*/
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                    top: 15.0,
                                                  ),
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        /*'Confirmed'*/
                                                        appointmentlist.status,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        /*'23-Nov-2020-11:30AM'*/
                                                        appointmentlist.appdate+" "+appointmentlist.appmonth,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(),
                                                      ),
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
                          ),
                        );
                      },
                      itemCount: doctorAppointmment.body.length,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    ));
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

  /*else if (comeFrom == Const.HEALTH_CHKUP_APNT) {
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.HEALTH_CHKUP_LIST + today,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                appointModel = lab.LabBookModel.fromJson(map);
              } else {
                isDataNotAvail = true;
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    }*/

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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    // _fname.text=patientProfileModel.body.fName;
    // _lname.text=patientProfileModel.body.lName;
    // _dob.text=patientProfileModel.body.dob;
    // _bloodGroup.text=patientProfileModel.body.bloodGroup;
    // _gender.text=patientProfileModel.body.gender;
    // _eMobile.text=patientProfileModel.body.eMobile;
    // _eName.text=patientProfileModel.body.eName;
    // _eRelation.text=patientProfileModel.body.eRelation;
    // _fDoctor.text=patientProfileModel.body.fDoctor;
    // _speciality.text=patientProfileModel.body.speciality;
    // _docMobile.text=patientProfileModel.body.docMobile;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // Future getCerificateImage() async {
                //   var image =
                //   await ImagePicker.pickImage(source: ImageSource.gallery);
                //   var enc = await image.readAsBytes();
                //   String _path = image.path;
                //
                //   String _fileName =
                //   _path != null ? _path.split('/').last : '...';
                //   var pos = _fileName.lastIndexOf('.');
                //   String extName =
                //   (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
                //   setState(() => _camImage = image);
                //   base64Img = base64Encode(enc);
                // }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   height: 110.0,
                      //   child: Center(
                      //     child: Container(
                      //       height: 110.0,
                      //       width: 110.0,
                      //       child: Stack(
                      //         children: [
                      //           // ClipRRect(
                      //           //     borderRadius: BorderRadius.circular(110.0),
                      //           //     child: _camImage != null
                      //           //         ? Image.file(
                      //           //       _camImage,
                      //           //       height: 110,
                      //           //       width: 110,
                      //           //       fit: BoxFit.cover,
                      //           //     )
                      //           //         : Image.network(
                      //           //         imgValue ?? AppData.defaultImgUrl,
                      //           //         height: 140)),
                      //           // Positioned(
                      //           //   child: InkWell(
                      //           //     onTap: () {
                      //           //       //getCameraImage();
                      //           //       //showDialog();
                      //           //       //_settingModalBottomSheet(context);
                      //           //       getCerificateImage();
                      //           //     },
                      //           //     child: Icon(
                      //           //       Icons.camera_alt,
                      //           //       color: Colors.black,
                      //           //       size: 20,
                      //           //     ),
                      //           //   ),
                      //           //   bottom: 3,
                      //           //   right: 12,
                      //           // )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 10),
                      Text(
                        "Update Profile",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                          });
                        },
                        // controller: _fname,
                        decoration: InputDecoration(hintText: "Medicine Name"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            // updateProfileModel.lName=value;
                          });
                        },
                        //controller: _lname,
                        decoration: InputDecoration(hintText: "Type"),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(hintText: "From Date"),
                      ),

                      Divider(height: 2, color: Colors.black),

                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(hintText: "To Date"),
                      ),
                      Divider(height: 2, color: Colors.black),

                      Row(
                        children: [
                          Text(
                            'Morning ',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            value: this._checkbox,
                            onChanged: (bool value) {
                              setState(() {
                                this._checkbox = value;
                              });
                            },
                          ),
                        ],
                      ),

                      Divider(height: 2, color: Colors.black),

                      Row(
                        children: [
                          Text(
                            'Afternoon ',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            value: this._checkbox,
                            onChanged: (bool value) {
                              setState(() {
                                this._checkbox = value;
                              });
                            },
                          ),
                        ],
                      ),

                      Divider(height: 2, color: Colors.black),

                      Row(
                        children: [
                          Text(
                            'Evening ',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            value: this._checkbox,
                            onChanged: (bool value) {
                              setState(() {
                                this._checkbox = value;
                              });
                            },
                          ),
                        ],
                      ),

                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        //controller: _docMobile,
                        decoration: InputDecoration(hintText: " Remarks"),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
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
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    /*codeDialog = valueText;
                    Navigator.pop(context);*/
                    // if (_fname.text == null || _fname.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter firstname");
                    // } else if (_bloodGroup.text == null || _bloodGroup.text == "") {
                    //   AppData.showInSnackBar(context, "Please choose Blood Group");
                    // } else if (_dob.text == null || _dob.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter eHealthcard Number");
                    // }else if (_gender.text == null || _gender.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Gender");
                    // }else if (_docMobile.text == null || _docMobile.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Contact Details");
                    // }else if (_eName.text == null || _eName.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Name");
                    // }else if (_eRelation.text == null || _eRelation.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Relation");
                    // }else if (_eMobile.text == null || _eMobile.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Mobile Number");
                    // }else if (_fDoctor.text == null || _fDoctor.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Doctors Name");
                    // }else if (_speciality.text == null || _speciality.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter Speciality");
                    // }
                    // else if (_lname.text == null || _lname.text == "") {
                    //   AppData.showInSnackBar(context, "Please enter last name");
                    // }else {
                    //   updateProfileModel.fName=_fname.text;
                    //   updateProfileModel.lName=_lname.text;
                    //   updateProfileModel.eCardNo=patientProfileModel.body.id;
                    //   updateProfileModel.fDoctor=_fDoctor.text;
                    //   updateProfileModel.fDoctor=_fDoctor.text;

                    // updateProfileModel.id=patientProfileModel.body.id;
                    // widget.model.POSTMETHOD_TOKEN(api: ApiFactory.USER_UPDATEPROFILE,
                    //     json: updateProfileModel.toJson(),
                    //     token: widget.model.token,
                    //     fun: (Map<String,dynamic>map){
                    //       Navigator.pop(context);
                    //       if (map[Const.STATUS] == Const.SUCCESS) {
                    //         // popup(context, map[Const.MESSAGE]);
                    //         AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    //       }else{
                    //         // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    //
                    //       }
                    //     });
                    //postEdit();
                  });
                },
              ),
            ],
          );
        });
  }
}
