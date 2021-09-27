import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  final MainModel model;

  const MyOrders({Key key, this.model}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders List',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          //leading: Icon(Icons.arrow_back, color: Colors.black),
           iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Container(
                    height: height * 0.27,
                    // color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.blueGrey[50],
                            Colors.blue[50]
                          ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5, bottom: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/confirmorder");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      'assets/discount2.jpg',
                                      width: width * 0.4,
                                      // height: height,
                                      height: height * 0.17,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '2021-07-06',
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              size: 15,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '19:41:10',
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Text(
                                          'Order ID: ',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'OD67867871941',
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.red[900]),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: Colors.red[900],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.blue),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: Colors.blue[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
