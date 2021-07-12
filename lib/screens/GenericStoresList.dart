import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class 

GenericStoresList extends StatefulWidget {
   MainModel model;
  GenericStoresList({Key key, this.model}) : super(key: key);
  @override
  _GenericStoresListState createState() => _GenericStoresListState();
}

class _GenericStoresListState extends State<GenericStoresList> {
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
                   Text('Generic Medical Stores ',
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
                                  padding: const EdgeInsets.only(left:20.0, right: 20.0,),
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
                                               height: 150,
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
                                                         children: [
                                                           Text('Ms. Paylla Tanaji sdul/ chaitali ram',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            SizedBox(height: 5,),
                                                          Text('Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik' ,
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
                                               height: 150,
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
                                                         children: [
                                                           Text('Ms. Paylla Tanaji sdul/ chaitali ram',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            SizedBox(height: 5,),
                                                          Text('Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik' ,
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
                                               height: 150,
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
                                                         children: [
                                                           Text('Ms. Paylla Tanaji sdul/ chaitali ram',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            SizedBox(height: 5,),
                                                          Text('Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik' ,
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
                                               height: 150,
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
                                                         children: [
                                                           Text('Ms. Paylla Tanaji sdul/ chaitali ram',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            SizedBox(height: 5,),
                                                          Text('Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik' ,
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
                                               height: 150,
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
                                                         children: [
                                                           Text('Ms. Paylla Tanaji sdul/ chaitali ram',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            SizedBox(height: 5,),
                                                          Text('Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik' ,
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