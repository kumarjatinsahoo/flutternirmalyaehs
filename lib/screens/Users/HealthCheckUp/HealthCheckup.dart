import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class HealthCheckup extends StatefulWidget {
  MainModel model;

  HealthCheckup({Key key, this.model}) : super(key: key);

  @override
  _HealthCheckupState createState() => _HealthCheckupState();
}

class _HealthCheckupState extends State<HealthCheckup> {
  var selectedMinValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: AppData.kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                    Text(MyLocalizations.of(context).text("HEALTH_CHECKUP"),
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Icon(Icons.search, color: Colors.white),
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, "/requestHealthCheakup"),
                              child: Container(
                                  height: 80,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey[300],
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [

                                        Material(
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/health_care.png",
                                                height: 40,
                                              )),
                                          elevation: 5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                MyLocalizations.of(context).text("FREE_HEALTH_CHECKUP"),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            /* GestureDetector(
                                             onTap: () =>   Navigator.pushNamed(context, "/myAppointment"),
                                             child: Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
                                               width: double.maxFinite,
                                              decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                     Icon(Icons.date_range_rounded, size: 50,color:AppData.kPrimaryColor),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('My Appointment',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),),
                                           GestureDetector(
                                             onTap: () =>   Navigator.pushNamed(context, "/findScreen"),
                                             child: Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
                                               width: double.maxFinite,

                                              decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,

                                                   children: [
                                                     Icon(Icons.search_rounded,size: 50,color:Colors.red),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Find',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),
                                           ),
                                           GestureDetector(
                                    onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                                    child:Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
                                               width: double.maxFinite,

                                              decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,

                                                   children: [
                                                     Icon(Icons.mobile_screen_share_outlined, size: 50,color:AppData.kPrimaryColor),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Medical Service',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),

                                  ),*/
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
}
