import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class SampleTracking extends StatefulWidget {
  final MainModel model;

  const SampleTracking({Key key, this.model}) : super(key: key);
  @override
  _SampleTrackingState createState() => _SampleTrackingState();
}

class _SampleTrackingState extends State<SampleTracking> {
  StepperType stepperType = StepperType.vertical;
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

 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
 Widget _showNeedHelpButton() {
    return Container(
      width: size.width * 0.25,
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


    List<Step> steps = [
      Step(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              'Order Placed',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            new Text(
              'We have received your order',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        content:
            Align(alignment: Alignment.topLeft, child: _showNeedHelpButton()),
        isActive: currentStep >= 0,
        state: currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              'Order Confirmed',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            new Text(
              'Your order has been confirmed',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        content: Column(
          children: <Widget>[],
        ),
        isActive: currentStep >= 0,
        state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              'Order Processed',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            new Text(
              'We are preparing your order',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        content: Column(
          children: <Widget>[],
        ),
        isActive: currentStep >= 0,
        state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              'Delivered',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            new Text(
              'Your order has been delivered',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        content: Column(
          children: <Widget>[],
        ),
        isActive: currentStep >= 0,
        state: currentStep >= 3 ? StepState.complete : StepState.disabled,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Delivery Tracking',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.30,
                child: Image.asset(
                  'assets/trackorder.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Divider(),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    steps: steps,
                    currentStep: currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    controlsBuilder:(BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Stack(
                        children: [SizedBox()],
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
