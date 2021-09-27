import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class DeliverdOrder extends StatefulWidget {
  final MainModel model;

  const DeliverdOrder({Key key,this.model}) : super(key: key);

  @override
  _DeliverdOrderState createState() => _DeliverdOrderState();
}

class _DeliverdOrderState extends State<DeliverdOrder> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Deliverd Order",
            style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.01,),
          Container(
            child: Image.asset("assets/trackorder.jpg",fit: BoxFit.cover,),
          ),
          Divider(thickness: 3,color: Colors.blue,),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stepper(
                      type: stepperType,
                      physics: NeverScrollableScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),

                      steps: <Step>[
                        Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                              Text("We have received your order",style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
 Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                              Text("We have received your order",style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
 Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                              Text("We have received your order",style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
 Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                              Text("We have received your order",style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
 Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text("Order Placed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                              Text("We have received your order",style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }



  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

}
