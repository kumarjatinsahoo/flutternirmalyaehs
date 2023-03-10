// import 'package:user/providers/app_data.dart';
// import 'package:user/scoped-models/MainModel.dart';
// import 'package:user/widgets/MyWidget.dart';
// import 'package:flutter/material.dart';
//
// class GenericStoresList extends StatefulWidget {
//   MainModel model;
//
//   GenericStoresList({Key key, this.model}) : super(key: key);
//
//   @override
//   _GenericStoresListState createState() => _GenericStoresListState();
// }
//
// class _GenericStoresListState extends State<GenericStoresList> {
//   var selectedMinValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               color: AppData.kPrimaryColor,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         )),
//                     Text(
//                       'Generic Medical Stores ',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w300,
//                           fontSize: 20,
//                           color: Colors.white),
//                     ),
//                     Icon(Icons.search, color: Colors.white),
//                   ],
//                 ),
//               ),
//               height: MediaQuery.of(context).size.height * 0.1,
//               width: MediaQuery.of(context).size.width,
//             ),
//             Expanded(
//               child: ListView(
//                 shrinkWrap: true,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 10.0,
//                       right: 10.0,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ListView(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           children: [
//                             Card(
//                               elevation: 5,
//                               child: Container(
//                                   height: 120,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         color: Colors.grey[300],
//                                       ),
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.ac_unit,
//                                             size: 50, color: Colors.red),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Apollo Pharmacy',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text(
//                                                 "Shop 1, H No.472/1,Mandar co-op hsg society,Near Busstop, Dhankwadi, Dhankwadi,Pune,Maharashtra 411043. India",
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                             Card(
//                               elevation: 5,
//                               child: Container(
//                                   height: 150,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         color: Colors.grey[300],
//                                       ),
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.ac_unit,
//                                             size: 50,
//                                             color: AppData.kPrimaryColor),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Ms. Paylla Tanaji sdul/ chaitali ram',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text(
//                                                 'Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik',
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                             Card(
//                               elevation: 5,
//                               child: Container(
//                                   height: 150,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         color: Colors.grey[300],
//                                       ),
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.ac_unit,
//                                             size: 50, color: Colors.red),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Ms. Paylla Tanaji sdul/ chaitali ram',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text(
//                                                 'Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik',
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                             Card(
//                               elevation: 5,
//                               child: Container(
//                                   height: 150,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         color: Colors.grey[300],
//                                       ),
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.ac_unit,
//                                             size: 50,
//                                             color: AppData.kPrimaryColor),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Ms. Paylla Tanaji sdul/ chaitali ram',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text(
//                                                 'Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik',
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                             Card(
//                               elevation: 5,
//                               child: Container(
//                                   height: 150,
//                                   width: double.maxFinite,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         color: Colors.grey[300],
//                                       ),
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.ac_unit,
//                                             size: 50, color: Colors.red),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Ms. Paylla Tanaji sdul/ chaitali ram',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text(
//                                                 'Jan Ausadhai Generic Medical Store, Shop No 16, Jan Ausadhai Generic Medical Store, Shop No 16,r Ground floor, Deepachana Complex B, wing Pune Nashik',
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Widget _submitButton() {
//     return MyWidgets.nextButton(
//       text: "search".toUpperCase(),
//       context: context,
//       fun: () {
//         //Navigator.pushNamed(context, "/navigation");
//         /*if (_loginId.text == "" || _loginId.text == null) {
//           AppData.showInSnackBar(context, "Please enter mobile no");
//         } else if (_loginId.text.length != 10) {
//           AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
//         } else {*/
//
//         // Navigator.pushNamed(context, "/otpView");
//         //}
//       },
//     );
//   }
// }


import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class GenericStoresList extends StatefulWidget {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: AppData.kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppData.white,
                            )),
                        Text(
                          'Generic Medical Stores ',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: AppData.white),
                        ),
                        Icon(Icons.search, color: AppData.white),
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
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                GestureDetector(
                                  // onTap: () => Navigator.pushNamed(context, "/insuranceDetalis"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5))),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.matruColor,
                                                      width: 5))),
                                          width: double.maxFinite,
                                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Apollo Pharmacy.',
                                                        style: TextStyle(fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Shop 1, H No.472/1,  Mandar     co-op hsg society,Near Busstop, Dhankwadi, Dhankawadi, Pune,Maharashtra 411043,India',
                                                        style: TextStyle(
                                                            fontSize: 15,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  shadowColor: Colors.grey,
                                  elevation: 10,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5))),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData.kPrimaryRedColor,
                                                    width: 5))),
                                        width: double.maxFinite,
                                        /*  margin: const EdgeInsets.only(top: 6.0),*/
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'MedPlus',
                                                      style: TextStyle( fontWeight:
                                                      FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Shop 3, H No.522/5,  Mandar     co-op hsg society,Near Busstop, Dhankwadi, Dhankawadi, Pune,Maharashtra 411043,India",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  shadowColor: Colors.grey,
                                  elevation: 10,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5))),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData.kPrimaryColor,
                                                    width: 5))),
                                        width: double.maxFinite,
                                        /*  margin: const EdgeInsets.only(top: 6.0),*/
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Patanjali Chikitsalaya',
                                                      style: TextStyle( fontWeight:
                                                      FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Near Akshya Garden Socity, Pune, Sambaji Nagar, Maharashtra 411017, India',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  shadowColor: Colors.grey,
                                  elevation: 10,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5))),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData.kPrimaryRedColor,
                                                    width: 5))),
                                        width: double.maxFinite,
                                        /*  margin: const EdgeInsets.only(top: 6.0),*/
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Apollo Pharrmacy',
                                                      style: TextStyle(fontWeight:
                                                      FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        'Near Akshya Garden Socity, Pune, Sambaji Nagar, Maharashtra 411017, India',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black)
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  shadowColor: Colors.grey,
                                  elevation: 10,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5))),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData.matruColor,
                                                    width: 5))),
                                        width: double.maxFinite,
                                        /*  margin: const EdgeInsets.only(top: 6.0),*/
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.blue,)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'MedPlus',
                                                      style: TextStyle(fontWeight:
                                                      FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Near Akshya Garden Socity, Pune, Sambaji Nagar, Maharashtra 411017, India',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              shadowColor: Colors.grey,
                              elevation: 10,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: AppData.kPrimaryRedColor,
                                                width: 5))),
                                    width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Image.asset("assets/Healttips.png",height: 50,width: 50,color: Colors.red,)
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Patanjali Chikitsalaya",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Near Akshya Garden Socity, Pune, Sambaji Nagar, Maharashtra 411017, India',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
