import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class DiscountOffersDetails extends StatefulWidget {
  MainModel model;

  DiscountOffersDetails({Key key, this.model}) : super(key: key);

  @override
  _DiscountOffersDetailsState createState() => _DiscountOffersDetailsState();
}

class _DiscountOffersDetailsState extends State<DiscountOffersDetails> {
  var selectedMinValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Icon(
                          Icons.arrow_back,
                          color: AppData.white,
                        )),
                    Text(
                      'Discount Offers ',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: AppData.white),
                    ),
                    Icon(Icons.search, color: AppData.white),
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
                             // onTap: () => Navigator.pushNamed(context, "/insuranceDetalis"),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                shadowColor: Colors.grey,
                                elevation: 10,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.matruColor,
                                                  width: 5))),
                                      width: double.maxFinite,
                                      /*  margin: const EdgeInsets.only(top: 6.0),*/
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Upto 35% Discount on Medical Books.',
                                                    style: TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Medilord.com',
                                                    style: TextStyle(
                                                        fontSize: 17,fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5))),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: AppData.kPrimaryRedColor,
                                                width: 5))),
                                    width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Upto 30% Discount on Products.',
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Medilord.com',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5))),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: AppData.kPrimaryColor,
                                                width: 5))),
                                    width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Upto 30% Discount on Pathology Test.',
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Sagar Diagnostics',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5))),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: AppData.kPrimaryRedColor,
                                                width: 5))),
                                    width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Upto 25% Discount on Medicine.',
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Appolo Pharmacy',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5))),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: AppData.matruColor,
                                                width: 5))),
                                    width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Flat 10% Discount on Indus Health Care',
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Indus Health',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          shadowColor: Colors.grey,
                          elevation: 10,
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: AppData.kPrimaryRedColor,
                                            width: 5))),
                                width: double.maxFinite,
                                /*  margin: const EdgeInsets.only(top: 6.0),*/
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Flat 20% Discount on Pathology Test',
                                              style: TextStyle(
                                                  fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'SRL Diagnostics',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                    ],
                                  ),
                                )),
                          ),
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
