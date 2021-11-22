import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
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
        title: Text(MyLocalizations.of(context).text("DELIVERD_ORDER"),
            style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.01,),
          Container(
            child: Image.asset("assets/Deliverdorder.jpg",fit: BoxFit.cover,),
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
                      onStepCancel: null,
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
                              new Text(MyLocalizations.of(context).text("ORDER_PLACED"),
                                style:
                              TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(MyLocalizations.of(context).text("WE_RCVD_UR_ORDER"),
                                style: TextStyle(color: Colors.grey,fontSize: 13),),
                              callButton(),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: StepState.complete,
                        ),
                        Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text(MyLocalizations.of(context).text("ORDER_CONFIRMED"),
                                style:
                              TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(MyLocalizations.of(context).text("ORDER_HASBEEN_CONFIRMED"),
                                style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                          //isActive: _currentStep >= 0,
                          state: StepState.complete,
                        ),
                        Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text(MyLocalizations.of(context).text("ORDER_PROCESSED"),
                                style:
                              TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(MyLocalizations.of(context).text("ORDER_PREPARING"),
                                style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                         // isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
                       Step(
                          content: Text(""),
                          title: Column(
                            children: [
                              new Text(MyLocalizations.of(context).text("READY_PICKUP"),
                                style:
                              TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(MyLocalizations.of(context).text("ORDER_READYTO_PICKUP"),
                                style: TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                         // isActive: _currentStep >= 0,
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

  Widget callButton() {
    return GestureDetector(
      onTap: () {
        // validate();
      },
      child: Container(
        // margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
          EdgeInsets.only(left: 35.0, right: 35.0, top: 12.0, bottom: 12.0),
          child: Text(
            MyLocalizations.of(context).text("CALL"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

}
