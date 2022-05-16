import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class ProccesedOrders extends StatefulWidget {
  final MainModel model;
  const ProccesedOrders({Key key, this.model}) : super(key: key);

  @override
  _ProccesedOrdersState createState() => _ProccesedOrdersState();
}

class _ProccesedOrdersState extends State<ProccesedOrders> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("PROCESSED_ORDER"),
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
          Container(height: 80,
            child: Stepper(
              type: stepperType,
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepCancel: null,
              physics: NeverScrollableScrollPhysics(),
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}){
                return Container();
              },

              onStepContinue: null,
                steps: <Step>[
                  Step(
                    content: Text(""),
                    title: Column(
                      children: [
                        new Text(MyLocalizations.of(context).text("PLACED"),
                          style:
                        TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: StepState.complete,
                  ),

                  Step(
                    content: Text(""),
                    title: Column(
                      children: [
                        new Text(MyLocalizations.of(context).text("PROCESSING"),style:
                        TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                      ],
                    ),
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                   Step(
                    content: Text(""),
                    title: Column(
                      children: [
                        new Text(MyLocalizations.of(context).text("DISPATCHED"),style:
                        TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                      ],
                    ),
                     state: _currentStep >= 0 ?
                     StepState.complete : StepState.disabled,
                  ),
                ]
            ),
          ),

          Card( color: Colors.blue[50],
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Column(
                            children: [
                              Text(MyLocalizations.of(context).text("ORDER_NO"),
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Y188967878578',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                            ],
                          )),
                      Column(
                        children: [
                          Text(MyLocalizations.of(context).text("PHARMACY"),
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Al Nadi Pharmacy',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text(MyLocalizations.of(context).text("DELIVER_TO"),
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Work - Sssss',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))


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

