import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppointmentConfirmed extends StatefulWidget {
   MainModel model;
  MyAppointmentConfirmed({Key key, this.model}) : super(key: key);
  @override
  _MyAppointmentConfirmedState createState() => _MyAppointmentConfirmedState();
}

class _MyAppointmentConfirmedState extends State<MyAppointmentConfirmed> {
  DateTime selectedDate = DateTime.now();
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {

      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      toThis_.text = df.format(date);

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
           body: Container(
             child: Column(
               children: [
               Container(
               height: 40,
               width: 190,
               margin: EdgeInsets.only(top: 20, bottom: 10),
               child: Expanded(
                   child: InkWell(
                     onTap: () {
                       print("Click done");
                       _selectDate(context);
                     },
                     child: AbsorbPointer(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 15, right: 15),
                         child: TextFormField(
                           autofocus: false,
                           controller: fromThis_,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.calendar_today),
                             floatingLabelBehavior:
                             FloatingLabelBehavior.always,
                             hintText: 'From this',
                             //labelText: 'Booking Date',
                             alignLabelWithHint: false,
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.blue,
                               ),
                             ),
                             contentPadding:
                             EdgeInsets.only(left: 10, top: 4, right: 4),
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey,
                                 width: 1.0,
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),),
                /*  Container(
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
              ),*/
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
                                                           Text('Confirmed',
                                                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.green),),
                                                           SizedBox(height: 3, ),
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
                                                             Text('Confirmed',
                                                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.green),),
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
                                                        Text('Confirmed',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.green),),
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
                                                        Text('Confirmed',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.green),),
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
                                                        Text('Confirmed',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.green),),
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
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
      /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(picked));


      });
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