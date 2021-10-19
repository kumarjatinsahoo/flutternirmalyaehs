import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class InsuranceList extends StatefulWidget {
  MainModel model;

  InsuranceList({Key key, this.model}) : super(key: key);

  @override
  _InsuranceListState createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {
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
                  'Insurance ',
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
                          onTap: () => Navigator.pushNamed(
                              context, "/insuranceDetalis"),
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
                                  height: 100,
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ICIC Prudential Pvt.Ltd',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '25000.00',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Premium Amount',
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                        Image.asset(
                                          "assets/forwardarrow.png",
                                          fit: BoxFit.fitWidth,
                                          /*width: 50,*/
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                              /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                          ),*/
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                                height: 100,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ICIC Prudential Pvt.Ltd',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '25000.00',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Premium Amount',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                      Image.asset(
                                        "assets/forwardarrow.png",
                                        fit: BoxFit.fitWidth,
                                        /*width: 50,*/
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )),
                            /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                          ),*/
                          ),
                        ),
                        /* ),*/
                        SizedBox(
                          height: 10,
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
                                height: 100,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ICIC Prudential Pvt.Ltd',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '25000.00',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Premium Amount',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                      Image.asset(
                                        "assets/forwardarrow.png",
                                        fit: BoxFit.fitWidth,
                                        /*width: 50,*/
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )),
                            /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                          ),*/
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                            height: 100,
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ICIC Prudential Pvt.Ltd',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '25000.00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Premium Amount',
                                          overflow: TextOverflow.clip,
                                          style:
                                              TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                  Image.asset(
                                    "assets/forwardarrow.png",
                                    fit: BoxFit.fitWidth,
                                    /*width: 50,*/
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )),
                        /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                          ),*/
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
