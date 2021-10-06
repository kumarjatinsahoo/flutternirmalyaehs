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
          appBar: AppBar(
            backgroundColor: AppData.kPrimaryColor,
            title: Text('Immunization'),
            /* leading: Icon(
            Icons.menu,
          ),*/
            actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )
              ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           /* Container(
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
            ),*/
            Center(
              child: Text('No immunization found',
                style: TextStyle( fontSize: 12),),
            ),
            /*Expanded(
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
                          height: 5,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
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
                                                      child: Image.asset("assets/greeninjection.png",height: 40,)

                                                  )),

                                            ])),
                                    *//* new Spacer(),*//*

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
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
                                              style: TextStyle(color: Colors.green),),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Image.asset("assets/green40.png",height: 30,)
                                              )),

                                          *//* SizedBox(width: 100,),*//*

                                        ])*//*),*//*
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
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
                                                      child: Image.asset("assets/redinjection40.png",height: 40,)

                                                  )),

                                            ])),
                                    *//* new Spacer(),*//*

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
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
                                              style: TextStyle(color: AppData.kPrimaryRedColor),),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Image.asset("assets/red40.png",height: 30,)
                                              )),

                                          *//* SizedBox(width: 100,),*//*

                                        ])*//*),*//*
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
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
                                                      child: Image.asset("assets/greeninjection.png",height: 40,)

                                                  )),

                                            ])),
                                    *//* new Spacer(),*//*

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
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
                                              style: TextStyle(color: Colors.green),),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spic,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                              },
                                              child: Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Image.asset("assets/green40.png",height: 30,)
                                              )),

                                          *//* SizedBox(width: 100,),*//*

                                        ])*//*),*//*
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
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
                                                  child: Image.asset("assets/redinjection40.png",height: 40,)

                                              )),

                                        ])),
                                *//* new Spacer(),*//*

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
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
                                          style: TextStyle(color: AppData.kPrimaryRedColor),),
                                      ],
                                    ),
                                  ),
                                ),

                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Navigator.pop(context);
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: Image.asset("assets/red40.png",height: 30,)
                                          )),

                                      *//* SizedBox(width: 100,),*//*

                                    ])*//*),*//*
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
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
