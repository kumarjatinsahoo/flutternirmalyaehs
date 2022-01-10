import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class DonorOrganisation extends StatefulWidget {
  MainModel model;

  DonorOrganisation({Key key, this.model}) : super(key: key);

  @override
  _DonorOrganisationState createState() => _DonorOrganisationState();
}

class _DonorOrganisationState extends State<DonorOrganisation> {
  var selectedMinValue;
  double tileSize = 80;
  double spaceTab = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    centerTitle: true,
    backgroundColor:AppData.kPrimaryColor,
    title: Text(
      MyLocalizations.of(context).text("DONOR_ORGANIZATION"),
      style: TextStyle(
          fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
    ),
      ),
      body: Container(
    child: Column(
      children: [
        ListView(
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
                        onTap: () {
                          widget.model.medicallserviceType =
                              MyLocalizations.of(context).text("BLOOD_DONATION");
                          Navigator.pushNamed(context, "/medicalsServiceOngooglePage");
                               //AppData.showInSnackBar(context,"hi");
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
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(color: AppData.kPrimaryRedColor,
                                      padding: EdgeInsets.all(3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/blood-donation.png",),
                                      ),
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
                                          Text(MyLocalizations.of(context).text("BLOOD_DONATION"),
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
                        onTap: () {
                          widget.model.medicallserviceType =
                              MyLocalizations.of(context).text("BONEMARROW_REGISTRY");
                          Navigator.pushNamed(
                              context, "/medicalsServiceOngooglePage");

                          // AppData.showInSnackBar(context,"hi");
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
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(color:AppData.kPrimaryBlueColor,
                                      padding: EdgeInsets.all(3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                        "assets/bone-marrow.png"
                                          ,
                                        ),
                                      ),
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
                                          Text(
                                            MyLocalizations.of(context).text("BONEMARROW_REGISTRY"),
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
