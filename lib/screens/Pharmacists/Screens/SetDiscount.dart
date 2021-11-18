import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class SetDisount extends StatefulWidget {
  final MainModel model;

  const SetDisount({Key key, this.model}) : super(key: key);
  @override
  _SetDisountState createState() => _SetDisountState();
}

class _SetDisountState extends State<SetDisount> {
   int _selectedDestination = -1;
   void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("DISCOUNT_OFFER"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white,),
      ),
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
           shrinkWrap: true,
           children: [
             Container(
                 height: size.height * 0.25,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(color: Colors.grey[200]),

                    ),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(5),
                                      child: Image.asset('assets/discount2.jpg',
fit: BoxFit.cover,
                   ),
                 )
               ),
               SizedBox(height: size.height * 0.02),
                Container(
                height: size.height * 0.25,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(color: Colors.grey[200]),

                    ),
                 child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                                      child: Image.asset('assets/discount1.jpg',
                   fit: BoxFit.cover,

                   ),
                 )
               ),
         SizedBox(height: size.height * 0.02),
          Container(
                 height: size.height * 0.25,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(color: Colors.grey[200]),

                    ),
                 child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                                      child: Image.asset('assets/discount2.jpg',
                                      fit: BoxFit.cover,

                   ),
                 )
               ),


           ],
         ),
    ),
    );
  }
}
