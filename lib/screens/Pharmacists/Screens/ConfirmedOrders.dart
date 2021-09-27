import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmOrders extends StatefulWidget {
  final MainModel model;

  const ConfirmOrders({Key key, this.model}) : super(key: key);

  @override
  _ConfirmOrdersState createState() => _ConfirmOrdersState();
}

class _ConfirmOrdersState extends State<ConfirmOrders> { 
  
 int _selectedDestination = -1;
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Orders',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor:AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),

       body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0),
                    child: Card(
                      child: Container(
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(5),
       border: Border.all(color: Colors.black12),    
                 gradient: LinearGradient(
            colors: [Colors.blueGrey[50], Colors.blue[50]])
                ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Order No: ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' 9102'),
                                     ],
                                   ),
                                   SizedBox(height: 10,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Text('Patient Name: ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' Seeama'),
                                     ],
                                   ),
                                   SizedBox(height: 10,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Text('Location : ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' Baner'),
                                     ],
                                   ),
                                 ],
                               ),
                             
                             Icon(Icons.more_vert)
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
