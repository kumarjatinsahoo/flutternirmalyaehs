import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:user/scoped-models/MainModel.dart';

class PaymentCollection extends StatefulWidget {
  final MainModel model;
  const PaymentCollection({Key key,this.model}) : super(key: key);

  @override
  _PaymentCollectionState createState() => _PaymentCollectionState();
}

class _PaymentCollectionState extends State<PaymentCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Collection"),
      ),
      backgroundColor:Colors.grey[250] ,
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child: Text("payment : 1,000"),
            ),
          ),
          //Divider(height: 20),
          Container(height: 50,color: Colors.blue,
            child: Image.asset("assets/UPI.jpg"),
          ),
        ],
      ),


    );
  }
}
