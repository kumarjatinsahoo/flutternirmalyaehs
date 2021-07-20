import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  MainModel model;
  TermsAndConditions({Key key, this.model}) : super(key: key);
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
                        child: Icon(
                          Icons.arrow_back,
                          color: AppData.white,)),
                    Text(
                      'Terms and Conditions ',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: AppData.white),
                    ),
                   /*Icon(
                      Icons.search,color: AppData.white
                    ),*/
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
                      left: 20.0,
                      right: 20.0,
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "(Note: In case of online registration of pledge,one copy of the pledge will be retained by pledger, one by the institution where pledge is made and a hard copy signe by pledger and two witnesses shall be sent to the nodal networking organisation.)",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Note: ',
                              style:
                              TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                           Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 0.0, top: 10.0, bottom: 10.0),
                              child: Row(
                              children: [
                               /* Text(
                                  'i. ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.w400, fontSize: 15,color: Colors.black),
                                ),*/
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 0.0, top: 10.0, bottom: 10.0),
                               child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "i. Organ donation is a family decision.Therefore ,it is important that you discuss your decision with family members and loved ones so that it will be easier foto follow through with your wishes.",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                             ),
                                ],
                            ),
                          ),

                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 0.0, top: 10.0, bottom: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ii. One copy  of the  pledge form/pledge card to be with respective networking organisation ,one copy to be retained by institution where the pledge is made and one copy to be handed over to the pledger.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 0.0, top: 10.0, bottom: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "iii. The person making the pledge has the option to withdraw the pledge.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                     Align(
                      alignment: Alignment.center,
                      child: Text(
                          'Contact Us ',
                          style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color: Colors.black),
                        ),
                     ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Website:http://WWW.notto.gov.in ',
                            style:
                            TextStyle(fontWeight: FontWeight.w200, fontSize: 15,color: Colors.black),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Email:dir@notto.nic.in',
                            style:
                            TextStyle(fontWeight: FontWeight.w200, fontSize: 15,color: Colors.black),
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
