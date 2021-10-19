import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class MedipediaPage extends StatefulWidget {
  MainModel model;

  MedipediaPage({Key key, this.model}) : super(key: key);

  @override
  _MedipediaPageState createState() => _MedipediaPageState();
}

class _MedipediaPageState extends State<MedipediaPage> {
  var selectedMinValue;

  @override
  Widget build(BuildContext context) {
    double tileSize=80;
    double spaceTab=20;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppData.kPrimaryColor,
            centerTitle: true,
            title: Text('Medipedia'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
          ],
          ),
      body: Container(
        child: Column(
          children: [
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
                               onTap: () =>  /* Navigator.pushNamed(context, "/bookanAppointmentlist")*/AppData.showInSnackDone(context, "Coming Soon"),
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
                                         Container(color:Colors.blue,child: Image.asset("assets/DiseaseInfo.png",height: 40,)),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Disease Info',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset("assets/Forwordarrow.png",height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),

                            GestureDetector(
                                onTap: () =>   /*Navigator.pushNamed(context, "/myAppointment")*/AppData.showInSnackDone(context, "Coming Soon"),
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
                                          Container(color:Colors.red,child: Image.asset("assets/Healthdays.png",height: 40,)),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Health Days',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset("assets/Forwordarrow.png",height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                              //Navigator.pushNamed(context, "/findScreen"),
                              Navigator.pushNamed(context, "/healthtipslist"),
                              //AppData.showInSnackDone(context, "Coming Soon"),
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
                                          Container(color:Colors.blue,child: Image.asset("assets/Healttips.png",height: 40,)),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Health Tips',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset("assets/Forwordarrow.png",height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                               onTap: () =>   Navigator.pushNamed(context, "/videos"),
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
                                        Container (color:Colors.red,child: Image.asset("assets/Videos.png",height: 40,)),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Videos',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset("assets/Forwordarrow.png",height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/medipediabg.png",fit: BoxFit.fill,),
            )
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
