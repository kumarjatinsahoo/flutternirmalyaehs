import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class ProccesedOrders extends StatefulWidget {
  final MainModel model;

  const ProccesedOrders({Key key, this.model}) : super(key: key);
  @override
  _ProccesedOrdersState createState() => _ProccesedOrdersState();
}

class _ProccesedOrdersState extends State<ProccesedOrders> {
  StepperType stepperType = StepperType.horizontal;
  int currentStep = 0;

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    currentStep < 3 ? setState(() => currentStep += 1) : null;
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }

  Widget _showNeedHelpButton() {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)))),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.call,
                size: 16,
              ),
              SizedBox(
                width: 2,
              ),
              Text('Call'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Processed Orders',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            SizedBox(height: size.height * 0.01,),
            Flexible(
              flex: 2,
                            child: Container(
                  // height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/trackorder.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            Divider(thickness: 1,),
                        
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estimated Delivery Time', style: TextStyle(color: Colors.black54, fontSize: 16),),
                           Text('1 hour', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                          SizedBox(height: size.height * 0.01,),
                          Container(
              // height: 300,
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                          "assets/images/verified.png",
                          color: Colors.blue,
          ),
          SizedBox(height: 5.0,),
          Text('Placed', style: TextStyle(color: Colors.black54,))
                    ],
                  ),
                  Expanded(
                                        child: Container(height: 2, color: Colors.black12,
                ),
                  ),  Column(
                    children: [
                      Image.asset(
                          "assets/images/verified.png",
                          color: Colors.blue,
          ),
          SizedBox(height: 5.0,),
          Text('Processing', style: TextStyle(color: Colors.black54))
                    ],
                  ),
                 Expanded(
                                        child: Container(height: 2, color: Colors.black12,
                ),
                 ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/dot-inside-a-circle.png",
                          color: Colors.amber[700],
          ),
          SizedBox(height: 5.0,),
          Text('Dispatched', style: TextStyle(color: Colors.black54))
                      ],
                    ),
          
                ],
              ), 
              
              ),
                        ],
                      ),
                    ),
                  ),
            ),
           
            Flexible(
              flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
               child: Container(
                   width: double.infinity,
                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(child: Column(
                             children: [
                               Text('Order Number',style: TextStyle(color: Colors.black54),),
                               Text('Y188967878578',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                             ],
                           )),
                         
                         
                         Container(child: Column(
                             children: [
                               Text('Pharmacy',style: TextStyle(color: Colors.black54),),
                                Text('Al Nadi Pharmacy',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                             ],
                           )),
                        
                          
                         Container(child: Column(
                             children: [
                               Text('Deliver To',style: TextStyle(color: Colors.black54),),
                               Text('Work - Sssss',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                             ],
                           )),
                         
                       ],
                     ),
                   ),
                 )
              ),
                            ),
            )
         
          ],
        ),
      ),
    );
  }
}
