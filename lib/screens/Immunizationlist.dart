import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class Immunizationlist extends StatefulWidget {
  MainModel model;
  Immunizationlist({Key key, this.model}) : super(key: key);
  @override
  _ImmunizationlistState createState() => _ImmunizationlistState();
}

class _ImmunizationlistState extends State<Immunizationlist> {
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
                      'Immunization',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: AppData.white),
                    ),
                    Icon(
                      Icons.search,color: AppData.white
                    ),
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
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey, width: 0.7),
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                    Container(
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spic,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0, right: 10.0),
                                                    child: Icon(
                                                      Icons.animation,
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                              /* SizedBox(width: 100,),*/
                                            ])),
                                   /* new Spacer(),*/

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Prescrlbed by:Dr Manasl Pathak',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('18-jan-2019',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('Hepatitis B Vaccine' ,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                    ),
                                    new Spacer(),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                                },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              )),

                                          /* SizedBox(width: 100,),*/

                                        ])/*),*/
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey, width: 0.7),
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                    Container(
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spic,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0, right: 10.0),
                                                    child: Icon(
                                                      Icons.animation,
                                                      color: Colors.green,
                                                    ),
                                                  )),
                                              /* SizedBox(width: 100,),*/
                                            ])),
                                   /* new Spacer(),*/

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Prescrlbed by:Dr Manasl Pathak',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('18-jan-2019',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('Hepatitis B Vaccine' ,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                    ),
                                    new Spacer(),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Icon(
                                                  Icons.done_outline_rounded,
                                                  color: Colors.green,
                                                ),
                                              )),

                                          /* SizedBox(width: 100,),*/
                                        ])/*),*/
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey, width: 0.7),
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                    Container(
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spic,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0, right: 10.0),
                                                    child: Icon(
                                                      Icons.animation,
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                              /* SizedBox(width: 100,),*/
                                            ])),
                                    /*new Spacer(),*/

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Prescrlbed by:Dr Manasl Pathak',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('18-jan-2019',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                          SizedBox(height: 5,),
                                          Text('Hepatitis B Vaccine' ,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                    ),
                                    new Spacer(),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              )),

                                          /* SizedBox(width: 100,),*/

                                        ])/*),*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              // color: Colors.indigo[50],
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey, width: 0.7),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spic,
                              children: [
                                Container(
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Icon(
                                                  Icons.animation,
                                                  color: Colors.green,
                                                ),
                                              )),
                                          /* SizedBox(width: 100,),*/
                                        ])),
                                /*new Spacer(),*/

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Prescrlbed by:Dr Manasl Pathak',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                      SizedBox(height: 5,),
                                      Text('18-jan-2019',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                      SizedBox(height: 5,),
                                      Text('Hepatitis B Vaccine' ,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                ),
                                new Spacer(),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.done_outline_rounded,
                                              color: Colors.green,
                                            ),
                                          )),

                                      /* SizedBox(width: 100,),*/
                                    ])/*),*/
                              ],
                            ),
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
