import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class InsuranceDetalis extends StatefulWidget {
  MainModel model;
  InsuranceDetalis({Key key, this.model}) : super(key: key);
  @override
  _InsuranceDetalisState createState() => _InsuranceDetalisState();
}

class _InsuranceDetalisState extends State<InsuranceDetalis> {
  var selectedMinValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Insurance"),
        centerTitle: true,
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
                    child: Icon(
                      Icons.arrow_back,
                      color: AppData.white,)),
                Text(
                  'Insurance ',
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

                        Container(
                        height: 90,
                            width: double.maxFinite,
                                /*  margin: const EdgeInsets.only(top: 6.0),*/
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('ICIC Prudential Pvt.Ltd',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: AppData.kPrimaryColor),),
                                            SizedBox(height: 5,),
                                            Text('Policy No:1478714',
                                                style: TextStyle(color: Colors.black54,fontSize: 16),),
                                            SizedBox(height: 5,),
                                            Text('Contact No:9020234567' ,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(color: Colors.black54,fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                      //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),


                                    ],
                                  ),
                                )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Policy Name',
                                          style: TextStyle(color: Colors.black54,fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('Life Insurance',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                ],
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Insurance Type',
                                          style: TextStyle(color: Colors.black54,fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('Health',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                ],
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Third party Administrator',
                                          style: TextStyle(color: Colors.black54,fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('No',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                ],
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Sum Assured Amount',
                                          style: TextStyle(color: Colors.black54,fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('5000000.00',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                ],
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Total insurance Amount',
                                          style: TextStyle(color: Colors.black54,fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('840000.00',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                ],
                              ),
                            )),
                       /* Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                        ),*/
                      /*  Container(
                          height: 50,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,*/

                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text(
                                        'Start Date',
                                        style: TextStyle(
                                            fontSize: 14,

                                            color: Colors.black38),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: Colors.black26),
                                          /*color: Colors.blue[50]*/),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'monday',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black38),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      ' march 2017',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                              SizedBox(
                                width: 10,
                              ),
                  /* Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0),
                      child: Image.asset("assets/images/callambulance.png",height: 30,)
                  ),
*/                             CircularPercentIndicator(
                                    radius: 100.0,
                                    lineWidth: 10.0,
                                    percent: 0.8,
                                    header: new Text("Icon header"),
                                    center: new Icon(
                                      Icons.person_pin,
                                      size: 50.0,
                                      color: Colors.blue,
                                    ),
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.blue,
                                  ),

                              SizedBox(
                                width: 10,
                              ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text(
                                        'End Date',
                                        style: TextStyle(
                                            fontSize: 14,

                                            color: Colors.black38),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: Colors.black26),
                                          /*color: Colors.blue[50]*/),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'monday',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black38),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      ' march 2021',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                          ),
                      ],
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
