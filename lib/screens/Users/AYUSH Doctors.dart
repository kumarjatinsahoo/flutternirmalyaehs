import 'package:user/providers/Const.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class 

AYUSHDoctors extends StatefulWidget {
   MainModel model;
  AYUSHDoctors({Key key, this.model}) : super(key: key);
  @override
  _AYUSHDoctorsState createState() => _AYUSHDoctorsState();
}

class _AYUSHDoctorsState extends State<AYUSHDoctors> {
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
                        child: Icon(Icons.arrow_back,color: Colors.white, )),
                   Text('AYUSH Doctors',
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
                                  padding: const EdgeInsets.only(left:10.0, right: 10.0,),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [    
                                      SizedBox(height: 10,), 
                                       ListView(
                                         shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         children: [
                                           InkWell(
                                             onTap: () {
                                               widget.model.medicallserviceType = "Ayurvada";
                                               Navigator.pushNamed(context, "/medicalsServiceOngooglePage");

                                               // AppData.showInSnackBar(context,"hi");
                                             },

                                                 /*widget.model.apntUserType = "ayurvada";
                                                 Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
                                             child: Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
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
                                                     Icon(Icons.ac_unit, size: 50,color: Colors.red),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Ayurvada',
                                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),


                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),
                                           ),
                                           InkWell(
                                             onTap: () {
                                               widget.model.medicallserviceType = "Homeopathy";
                                               Navigator.pushNamed(context, "/medicalsServiceOngooglePage");
                                             },
                                           child:Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
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
                                                     Icon(Icons.ac_unit, size: 50,color: AppData.kPrimaryColor),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Homeopathy',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),),
                                           InkWell(
                                             onTap: () {
                                               widget.model.medicallserviceType = "Siddha Treatment";
                                               Navigator.pushNamed(context, "/medicalsServiceOngooglePage");
                                             },
                                            child:Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
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
                                                     Icon(Icons.ac_unit, size: 50,color: Colors.red),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Siddha Treatment',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),),
                                  GestureDetector(
                                    onTap: () {
                                      widget.model.medicallserviceType = "Unani";
                                      Navigator.pushNamed(context, "/medicalsServiceOngooglePage");
                                    },
                                    //onTap: () =>   Navigator.pushNamed(context, "/setdiscount"),
                                    child:Card(
                                             elevation: 5,
                                                     child: Container(
                                               height: 100,
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
                                                     Icon(Icons.ac_unit, size: 50,color: AppData.kPrimaryColor),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Unani',
                                                             style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )),
                                           ),

                                  ),
                                           GestureDetector(
                                             onTap: () {
                                               widget.model.medicallserviceType = "Yoga & Naturopathy";
                                               Navigator.pushNamed(context, "/medicalsServiceOngooglePage");
                                             },
                                           child:Card(
                                             elevation: 5,
                                             child: Container(
                                                 height: 100,
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
                                                       Icon(Icons.ac_unit, size: 50,color: Colors.red),
                                                       SizedBox(width: 10,),
                                                       Expanded(
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: [
                                                             Text('Yoga & Naturopathy',
                                                               style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 )),
                                           )),
                                         ],
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