import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class FindHealthcareService extends StatefulWidget {
  MainModel model;

  FindHealthcareService({Key key, this.model}) : super(key: key);

  @override
  _FindHealthcareServiceState createState() => _FindHealthcareServiceState();
}

class _FindHealthcareServiceState extends State<FindHealthcareService> {
  var selectedMinValue;
  LoginResponse1 loginResponse1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 80;
    double spaceTab = 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text(MyLocalizations.of(context).text("HEALTHCARE_SERVICE")),
        centerTitle: true,
        /* leading: Icon(
        Icons.menu,
      ),*/
        actions: <Widget>[
          /*  Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),*/
          /*Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                  Icons.more_vert
              ),
            )
        ),*/
        ],
      ),
      body: Container(
        child: Column(
          children: [
            /*Container(
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
                Text(
                  'Find Healthcare Service ',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.white),
                ),
               // Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
        ),*/
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
                            (loginResponse1.body?.userStateId != null&&loginResponse1.body.userStateId  != "21" )?
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/appointmenttab");
                                /*Navigator.pushNamed(
                                    context, "/doctorconsultationPage");*/
                                /* Navigator.pushNamed(context, "/docConsult1");*/
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryRedColor,
                                            padding: EdgeInsets.all(3),
                                            child: Icon(Icons.date_range,
                                                size: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("BOOK_APPOINTMENT"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ):Container(),
                            (loginResponse1.body?.userStateId != null&&loginResponse1.body.userStateId  != "21" )?
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/myAppointment");

                                /*Navigator.pushNamed(
                                    context, "/userAppoint");*/
                                /* Navigator.pushNamed(
                                    context, "/Appointtab");*/
                              }
                              ,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryBlueColor,
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                                Icons.date_range_rounded,
                                                size: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("MY_APPOINTMENT"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ):Container(),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(
                                      context, "/findScreen"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryRedColor,
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                                Icons.search_rounded,
                                                size: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("FIND"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(
                                      context, "/medicalService"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryBlueColor,
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                                Icons
                                                    .mobile_screen_share_outlined,
                                                size: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("MEDICAL_SERVICE"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
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
    );
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
