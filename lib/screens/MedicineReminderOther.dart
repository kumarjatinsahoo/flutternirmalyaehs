import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class MedicineReminderOther extends StatefulWidget {
  MainModel model;
  MedicineReminderOther({Key key, this.model}) : super(key: key);
  @override
  _MedicineReminderOtherState createState() => _MedicineReminderOtherState();
}

class _MedicineReminderOtherState extends State<MedicineReminderOther> {
  var selectedMinValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
           body: Container(
             child: Column(
               children: [
                  Container(
             color: AppData.kPrimaryColor ,
                child: Padding(
                  padding: const EdgeInsets.only( left:15.0,right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,color:Colors.white )),
                   Padding(
                     padding: const EdgeInsets.only(left: 60.0, right: 40.0),
                     child: Text('Medicine Reminder',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color:Colors.white),),
                   ),
                        Icon(Icons.search,color:Colors.white ),
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
              ),
              Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                padding: const EdgeInsets.only(left:10.0, right: 10.0,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [    
                                    SizedBox(height: 10,), 
                                    ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Column(
                                               children: [
                                                 Text(
                                      'June 21',
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
                                      'June 21',
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
                                      'June 25',
                                      style: TextStyle(color: AppData.kPrimaryColor),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '25',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: AppData.kPrimaryColor),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Tue',
                                      style: TextStyle(color: AppData.kPrimaryColor),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),
                                           Column(
                                               children: [
                                                 Text(
                                      'June 21',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '26',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Wed',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                         SizedBox(width: 20,),
                                           Column(
                                               children: [
                                                 Text(
                                      'June 21',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      '27',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10,),
                                      Text(
                                      'Thu',
                                      style: TextStyle(),
                                    ),
                                               ],
                                             ),
                                        
                                           ],
                                         ),
                                        //  ListView(
                                        //    shrinkWrap: true,
                                        //    children: [
                                        //      Container(child: Text('10.00 AM'))])
                                        SizedBox(height: 20,),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
  separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
  itemCount: 3,
  itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(
              height: 40,
              /*color: Colors.indigo,*/
                color: AppData.kPrimaryColor,
              width: double.infinity,
              child: Center(child: Text("07.25 PM $index", style: TextStyle(color: Colors.white),)))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('title'),
                    Icon(Icons.close, color: Colors.red,)
                  ],
                ),
              )
          ],
        ),
      ),
)
                                      ],
                                    ),

                              
                               
                                ],),
                              ),
                ),
              ),
               ],
             ),
           ),
           floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 29,),
        backgroundColor: AppData.kPrimaryColor,
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
  //   MaterialPageRoute(builder: (context) => MedicineReminderOtherList()),
  // );
      },
    );
  }

  
}