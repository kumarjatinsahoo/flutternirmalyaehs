
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';


class MedicineReminder extends StatefulWidget {
  MainModel model;
  MedicineReminder({Key key, this.model}) : super(key: key);
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,color: Colors.white)),
                   Padding(
                     padding: const EdgeInsets.only(left: 60.0, right: 40.0),
                     child: Text('Medicine Reminder',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white),),
                   ),
                        Icon(Icons.search,color: Colors.white ),
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
              ),
                
                /* Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     DatePicker(
                       DateTime.now(),
                       initialSelectedDate: DateTime.now(),
                       selectionColor: Colors.black,
                       selectedTextColor: Colors.white,
                       onDateChange: (date) {
                         // New date selected
                         setState(() {
                           _selectedValue = date;
                         });
                       },
                     ),
                   ],
                 )*/
                /* Container(
                     child: CalendarStrip(
                       startDate: startDate,
                       endDate: endDate,
                       onDateSelected: onSelect,
                       dateTileBuilder: dateTileBuilder,
                       iconColor: Colors.black87,
                       //monthNameWidget: _monthNameWidget,
                       markedDates: markedDates,
                       containerDecoration: BoxDecoration(color: Colors.black12),
                     )),*/

              Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                padding: const EdgeInsets.only(left:25.0, right: 25.0,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [    
                                    SizedBox(height: 10,), 
                                    ListView(
                                      shrinkWrap: true,
                                      children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Column(
                                               children: [
                                                 Text(
                                      'June 1',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '23',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Mon',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),    
                                         Column(
                                               children: [
                                                 Text(
                                      'June 1',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '24',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Mon',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),
                                           Column(
                                               children: [
                                                 Text(
                                      'June 1',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '25',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Mon',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),
                                           Column(
                                               children: [
                                                 Text(
                                      'June 1',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '26',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Mon',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),
                                           Column(
                                               children: [
                                                 Text(
                                      'June 1',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '27',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Mon',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                        //  SizedBox(width: 20,),
                                           ],
                                         ),
                                      ],
                                    ),
                                SizedBox(height: 300,),
                                 Column(
                                   children: [
                                     Center(
                                       child: Text(
                                            'Set Reminder for Medicines, Water intake or any other Medical Needs',
                                            style: TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                     ),
                                      SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200]
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Medicine'),
                                        )),
                                      ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/setreminder");
            },
            child: Container(
              height: 40,
              child: Icon(Icons.mediation, color: Colors.white, size: 29,)),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: AppData.kPrimaryColor,),
          ),
                                    ],
                                  ), 
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200]
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Other'),
                                        )),
                                      ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/medicinereminderother");
            },
            child: Container(
                height: 40,
                child: Icon(Icons.library_books_outlined, color: Colors.white, size: 29,)),
                                        style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: Colors.red[700]),
          ),
                                    ],
                                  ),
          
                                   ],
                                 ),  
                                
          SizedBox(height: 10,),
                               
                                ],),
                              ),
                ),
              ),
               ],
             ),
           ),


           floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.delete, color: Colors.white, size: 29,),
        backgroundColor:AppData.kPrimaryColor,
        elevation: 5,
        splashColor: Colors.grey,
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
  //        Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => MedicineReminderList()),
  // );
      },
    );
  }

  
}

