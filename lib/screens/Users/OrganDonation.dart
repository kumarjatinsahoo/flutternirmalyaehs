import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class OrganDonation extends StatefulWidget {
  MainModel model;
  OrganDonation({Key key, this.model}) : super(key: key);
  @override
  _OrganDonationState createState() => _OrganDonationState();
}

class _OrganDonationState extends State<OrganDonation> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppData.kPrimaryColor,
          title: Text(
            'Organ Donation',
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 20,color:Colors.white),
          ),
        ),
        body: Container(
          child: Column(
            children: [

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                    child: Container(
                      height: 400,
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 40,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black12),
                                    gradient: LinearGradient(colors: [
                                      Colors.blueGrey[50],
                                      Colors.blue[50]
                                    ])),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Image.asset(
                                          'assets/intro/organ1.jpeg',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Which Organ?',
                                  // 'What is Organ Donation?',
                                  style: TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                         Column(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   border: Border.all(color: Colors.black12),
                                   gradient: LinearGradient(colors: [
                                     Colors.blueGrey[50],
                                     Colors.blue[50]
                                   ])),
                               child: Center(
                                 child: Column(
                                   mainAxisAlignment:
                                       MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(30.0),
                                       child: Image.asset(
                                         'assets/intro/organ2.jpeg',
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Expanded(
                               child: Text(
                                 'Who Can Do?',
                                 style: TextStyle(fontSize: 12,
                                   fontWeight: FontWeight.w600,
                                 ),
                                 overflow: TextOverflow.clip,
                                 maxLines: 3,
                               ),
                             )
                           ],
                         ),
                         Column(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   border: Border.all(color: Colors.black12),
                                   gradient: LinearGradient(colors: [
                                     Colors.blueGrey[50],
                                     Colors.blue[50]
                                   ])),
                               child: Center(
                                 child: Column(
                                   mainAxisAlignment:
                                       MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(30.0),
                                       child: Image.asset(
                                         'assets/intro/organ3.jpeg',
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Expanded(
                               child: Text(
                                 'Which Organs?',
                                 style: TextStyle(fontSize: 12,
                                   fontWeight: FontWeight.w600,
                                 ),
                                 overflow: TextOverflow.clip,
                                 maxLines: 3,
                               ),
                             )
                           ],
                         ),
                         Column(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   border: Border.all(color: Colors.black12),
                                   gradient: LinearGradient(colors: [
                                     Colors.blueGrey[50],
                                     Colors.blue[50]
                                   ])),
                               child: Center(
                                 child: Column(
                                   mainAxisAlignment:
                                       MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(30.0),
                                       child: Image.asset(
                                         'assets/intro/organ4.jpeg',
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Expanded(
                               child: Text(
                                 'How to Donate?',
                                 style: TextStyle(fontSize: 12,
                                   fontWeight: FontWeight.w600,
                                 ),
                                 overflow: TextOverflow.clip,
                                 maxLines: 3,
                               ),
                             )
                           ],
                         ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _applicationButton(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _applicationButton() {
    return MyWidgets.nextButton(
      text: "Application",
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        Navigator.pushNamed(context, "/donorApplication");

        //}
      },
    );
  }
}
