import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class 

TreatmentCenters extends StatefulWidget {
   MainModel model;
  TreatmentCenters({Key key, this.model}) : super(key: key);
  @override
  _TreatmentCentersState createState() => _TreatmentCentersState();
}

class _TreatmentCentersState extends State<TreatmentCenters> {
  var selectedMinValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
           body: Container(
             child: Column(
               children: [
                  Container(                   
                child: Padding(
                  padding: const EdgeInsets.only( left:15.0,right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, )),                      
                   Text('Treatment Centers',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                        Icon(Icons.search, ),
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
                                           GestureDetector(
                                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                     Icon(Icons.ac_unit, size: 50),
                                                     SizedBox(width: 10,),
                                                     Expanded(
                                                             child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           Text('Cancer',
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
                                             /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                         Icon(Icons.ac_unit, size: 50),
                                                         SizedBox(width: 10,),
                                                         Expanded(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Text('Cardiology',
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
                                             /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                         Icon(Icons.ac_unit, size: 50),
                                                         SizedBox(width: 10,),
                                                         Expanded(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Text('Diabetic',
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
                                             /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                         Icon(Icons.ac_unit, size: 50),
                                                         SizedBox(width: 10,),
                                                         Expanded(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Text('Neurology',
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
                                             /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                         Icon(Icons.ac_unit, size: 50),
                                                         SizedBox(width: 10,),
                                                         Expanded(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Text('Nephrology',
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
                                             /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                                         Icon(Icons.ac_unit, size: 50),
                                                         SizedBox(width: 10,),
                                                         Expanded(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               Text('Ophthalmology',
                                                                 style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
                                                             ],
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   )),
                                             ),
                                           ),
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