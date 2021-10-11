import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/AppointmentlistModel.dart' as apnt;
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';


class UserAppointments extends StatefulWidget {
  MainModel model;

  UserAppointments({Key key, this.model}) : super(key: key);

  @override
  _UserAppointmentsState createState() => _UserAppointmentsState();
}

class _UserAppointmentsState extends State<UserAppointments> {
  //PocReportModel pocReportModel;
  bool isDataNotAvail = false;
String userid;
  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  apnt.AppointmentlistModel appointmentlistModel;
  List<Body> body;


  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
  }
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        //api: ApiFactory.USER_APPOINTMENTS + loginResponse1.body.user,
        api: ApiFactory.APPOINT_LIST +loginResponse1.body.user+"&hospitalid=1",
        userId: loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              appointmentlistModel = apnt.AppointmentlistModel.fromJson(map);

            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Appointment'),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[
          ],
        ),
        body: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          // Container(
          //   // width: double.infinity,
          //   // /* decoration: BoxDecoration(
          //   //         image: DecorationImage(
          //   //             image: NetworkImage(
          //   //                 "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"
          //   //             ),
          //   //             fit: BoxFit.cover
          //   //         )
          //   //     ),*/
          //   // decoration: BoxDecoration(
          //   //     image: DecorationImage(
          //   //         image: AssetImage("assets/images/testbackgroundimg2.jpg"),
          //   //         fit: BoxFit.cover)),
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //       left: 20.0,
          //       top: 10.0,
          //     ),
          //
          //     child: Column(
          //       children: [
          //         // Text(
          //         //   "Appointment Details",
          //         //   style: TextStyle(
          //         //       fontSize: 18,
          //         //       color: Colors.white,
          //         //       fontWeight: FontWeight.w600),
          //         // ),
          //         // SizedBox(
          //         //   height: size.height * 0.04,
          //         // ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Container(
          //               //height: size.height * 0.07,
          //               //width: size.width * 0.13,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(55),
          //                   border: Border.all(color: Colors.black, width: 0.5),
          //                   color: Colors.black),
          //               child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(55),
          //                   child: Image.asset(
          //                     'assets/images/user.png',
          //                     height: size.height * 0.07,
          //                     width: size.width * 0.13,
          //                     //fit: BoxFit.cover,
          //                   )),
          //             ),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 loginResponse1.body.userName ?? "N/A",
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          (appointmentlistModel != null)
              ? InkWell(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      if (i == appointmentlistModel.body.length) {
                        return (appointmentlistModel.body.length % 10 == 0)
                            ? CupertinoActivityIndicator()
                            : Container();
                      }
                      apnt.Body patient = appointmentlistModel.body[i];
                      widget.model.userappointment=patient;
                      var string = patient.appdate;
                      List splitedText = string.split("-");
                      print(splitedText[0]);
                      String string1 = splitedText[1];
                      print("Print KAruchii>>>>"+string1);
                      print(splitedText[2]);
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            if(patient.status =="Treated"){
                              widget.model.userappointment=patient;
                              Navigator.pushNamed(context, "/usermedicinelist");
                            }
                            else{
                              // widget.model.userappointment=patient;
                              AppData.showInSnackBar(context," First Consult With Doctor  ");
                              // Navigator.pushNamed(context, "/usermedicinelist");

                            }
                          },
                          title: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                              string1,
                                    //AppData.getMonth(string1),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    /* '23'*/
                                    splitedText[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    /*'2016'*/
                                    splitedText[2],
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              /*Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 36,
                                      )),
                                ),*/
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.grey)),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    patient.doctorName + " ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    patient.speciality ?? "",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    textAlign: TextAlign.end,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    patient.status ?? "",
                                    style: TextStyle(
                                        color: getColorForStatus(patient.status),
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    patient.apptime ?? "",
                                    style: TextStyle(
                                        color: getColorForStatus(patient.status),
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                  /* Text(
                                      patient.patientUniqueid,
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.mobile??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.gender??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.age??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.screeningDate??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),*/
                                ],
                              ),
                            ],
                          ),
                          /*Text(
                              (i + 1).toString() + ". " + patient.name + " ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                            ),*/
                          /*subtitle: Row(

                              children: [
                                Column(
                                  children: [
                                    Text(
                                      */ /*'June '*/ /*AppData.getMonth(string1),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                     */ /* '23'*/ /*splitedText[2],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      */ /*'2016'*/ /*splitedText[0],
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                */ /*Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 36,
                                      )),
                                ),*/ /*
                                Container(height: 80, child: VerticalDivider(color: Colors.grey)),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                            Text(
                            patient.name + " ",
                            style: TextStyle(
                            color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    (patient.thpId == "")
                                        ? Container()
                                        : Text(
                                      patient.thpName??"",
                                      style: TextStyle(color: Colors.black,fontSize: 13, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                    */ /*Text(
                                      patient.screeningDate??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),*/ /*
                                   */ /* Text(
                                      patient.patientUniqueid,
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.mobile??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.gender??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.age??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      patient.screeningDate??"",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),*/ /*
                                  ],
                                ),
                              ],
                            ),*/
                          //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                          trailing: Column(
                            children: [
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      );
                    },
                    itemCount: appointmentlistModel.body.length,
                  ),
              )
              : Container(),
        ],
      ),
    ));
    /*body: ListTile(
        onTap: () {
        },
        title: Text(
          (i + 1).toString() +
              ". " +
              patient.firstName +
              " " +
              patient.midName ??
              "" + patient.lastName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              patient.sector,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              patient.pregnancyRegDt,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
            Text(
              patient.husbandFatherNm,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
        trailing: Icon(Icons.arrow_right_outlined),
      ),*/
  }

  Color getColorForStatus(name) {
    switch (name) {
      case "Confirmed":
        return Colors.green;
      case "Pending":
        return Colors.yellow[800];
      case "Requested":
        return Colors.yellow[800];
        // case "Requested":
        // return Colors.yellow[800];
      default:
        return Colors.black;
    }
  }
}
