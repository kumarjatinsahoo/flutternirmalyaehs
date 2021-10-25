import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final MainModel model;

  const ProfileScreen({Key key, this.model}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
                  child: Container(
                    // height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[400], Colors.blue[200]]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BMS Lab',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Text(
                                'Varun',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                '9643213455',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          Container(
                            // height: 95,
                            // width: 95,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(55),
                            //     border: Border.all(color: Colors.white, width: 0.5),
                            //     color: Colors.blue[50]
                            //     ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Image.asset(
                                  'assets/images/user.png',
                                  // height: 95,
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blueGrey[50], Colors.blue[50]]),
                    borderRadius: BorderRadius.circular(1),
                    // border: Border.all(color: Colors.blue[100]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Personal Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/images/edit.png',
                              color: Colors.grey[700],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Email Id:',
                              style: TextStyle(
                                  // color: Colors.black54,
                                  // fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(width: size.width * 0.06),
                            Text(
                              'meditechpath.lab@gmail.com',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                // color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Address:',
                              style: TextStyle(
                                  // fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(width: size.width * 0.06),
                            Text(
                              'Viman nagar, pune',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Location:',
                              style: TextStyle(
                                  // fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(width: size.width * 0.06),
                            Text(
                              'Pune',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                // color: AppData.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Pincode:',
                              style: TextStyle(
                                  // color: AppData.kPrimaryColor,
                                  // fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(width: size.width * 0.06),
                            Text(
                              '751028',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                // color: AppData.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
