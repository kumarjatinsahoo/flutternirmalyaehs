import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class 

MyAppointment extends StatefulWidget {
   MainModel model;
  MyAppointment({Key key, this.model}) : super(key: key);
  @override
  _MyAppointmentState createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
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
                  padding: const EdgeInsets.only( left:15.0,right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,color: Colors.white )),
                   Text('My Appoinment',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white),),
                        Icon(Icons.search,color: Colors.white ),
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
                                  padding: const EdgeInsets.only(left:5.0, right: 5.0,),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [    
                                      SizedBox(height: 10,), 
                                       ListView(
                                         shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         children: [

                                           Card(
                                             elevation: 5,
                                             child: Container(
                                                 height: 120,
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
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                   Expanded(
                                                   child:  Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             Text('Dr.Maya Tulple',
                                                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                             SizedBox(height: 5,),
                                                             Text('Gen Physician' ,
                                                               overflow: TextOverflow.clip,
                                                               style: TextStyle(),),
                                                             SizedBox(height: 5,),
                                                             Text("Patient Notes:Lorem ipsum dolor"
                                                                 "Consectetar adipisicing elit" ,
                                                               overflow: TextOverflow.clip,
                                                               style: TextStyle(),),
                                                           ],
                                                         ),),
                                                       /*new Spacer(),*/
                                               Padding(
                                                 padding: const EdgeInsets.only( top: 15.0,),
                                                 child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                         crossAxisAlignment: CrossAxisAlignment.end,
                                                         children: [
                                                           Text('Requeested',
                                                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
                                                           SizedBox(height: 3,),
                                                           Text('23-Nov-2020-11:30AM' ,
                                                             overflow: TextOverflow.clip,
                                                             style: TextStyle(),),

                                                         ],
                                                       ),
                                               ),
                                                     ],
                                                   ),
                                                 )),
                                           ),

                                           Card(
                                             elevation: 5,
                                             child: Container(
                                                 height: 120,
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
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Expanded(
                                                         child:  Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             Text('Dr.Maya Tulple',
                                                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                             SizedBox(height: 5,),
                                                             Text('Gen Physician' ,
                                                               overflow: TextOverflow.clip,
                                                               style: TextStyle(),),
                                                             SizedBox(height: 5,),
                                                             Text("Patient Notes:Lorem ipsum dolor"
                                                                 "Consectetar adipisicing elit" ,
                                                               overflow: TextOverflow.clip,
                                                               style: TextStyle(),),
                                                           ],
                                                         ),),
                                                       /*new Spacer(),*/
                                                       Padding(
                                                         padding: const EdgeInsets.only( top: 15.0,),
                                                         child: Column(
                                                           // mainAxisAlignment: MainAxisAlignment.center,
                                                           crossAxisAlignment: CrossAxisAlignment.end,
                                                           children: [
                                                             Text('Requeested',
                                                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
                                                             SizedBox(height: 3,),
                                                             Text('23-Nov-2020-11:30AM' ,
                                                               overflow: TextOverflow.clip,
                                                               style: TextStyle(),),

                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 )),
                                           ),
                                         ],
                                       ),
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                            height: 120,
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
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Dr.Maya Tulple',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                        SizedBox(height: 5,),
                                                        Text('Gen Physician' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                        SizedBox(height: 5,),
                                                        Text("Patient Notes:Lorem ipsum dolor"
                                                            "Consectetar adipisicing elit" ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                      ],
                                                    ),),
                                                  /*new Spacer(),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only( top: 15.0,),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text('Requeested',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
                                                        SizedBox(height: 3,),
                                                        Text('23-Nov-2020-11:30AM' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                            height: 120,
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
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Dr.Maya Tulple',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                        SizedBox(height: 5,),
                                                        Text('Gen Physician' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                        SizedBox(height: 5,),
                                                        Text("Patient Notes:Lorem ipsum dolor"
                                                            "Consectetar adipisicing elit" ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                      ],
                                                    ),),
                                                  /*new Spacer(),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only( top: 15.0,),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text('Requeested',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
                                                        SizedBox(height: 3,),
                                                        Text('23-Nov-2020-11:30AM' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                            height: 120,
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
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Dr.Maya Tulple',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                        SizedBox(height: 5,),
                                                        Text('Gen Physician' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                        SizedBox(height: 5,),
                                                        Text("Patient Notes:Lorem ipsum dolor"
                                                            "Consectetar adipisicing elit" ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),
                                                      ],
                                                    ),),
                                                  /*new Spacer(),*/
                                                  Padding(
                                                    padding: const EdgeInsets.only( top: 15.0,),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text('Requeested',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
                                                        SizedBox(height: 3,),
                                                        Text('23-Nov-2020-11:30AM' ,
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(),),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
          
           SizedBox(height: 10,),
            
         
         
                                 
                                  ],),
                                ),
                              ],
                ),
              ),
               ],
             ),
           ),
                      
                      
          )  
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