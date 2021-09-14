import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/HealthChartResponse.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

final y = [12, 12, 23.5, 2, 19, 1, 23, 16, 29.7, 32, 45, 68, 23, 21, 69.1];
var yMin = y.reduce(min);
var yMax = y.reduce(max);

class HealthChart1 extends StatefulWidget {
  MainModel model;

  HealthChart1({Key key, this.model}) : super(key: key);

  @override
  _HealthChart1State createState() => _HealthChart1State();
}

class _HealthChart1State extends State<HealthChart1> {
  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginResponse;
  File pathUsr = null;
  HealthChartResponse healthChartResponse;

  final List<Color> gradientColors = [
    AppData.matruColor,
  ];

  final List<Color> gradientline = [
    Colors.blue,
    Colors.blue,
  ];
  List<FlSpot> heartrateList = [];
  List<FlSpot> tempList = [];
  List<FlSpot> oxygenList = [];
  List<FlSpot> demoList = [
    FlSpot(0, 94),
    FlSpot(60, 97),
    FlSpot(97, 100),
    // FlSpot(0, 3),
    //       FlSpot(2.6, 2),
    //       FlSpot(4.9, 5),
    //       FlSpot(6.8, 3.1),
    //       FlSpot(8, 4),
    //       FlSpot(9.5, 3),
    //       FlSpot(11, 4),
  ];
  List<FlSpot> bloodpssrList = [];
  List reportResponse = [];
  List bloodlevelResponse = [];
  List oxygenResponse = [];

  List<BarChartGroupData> bloodchart = [];

  List<ScreeningReport> screeningReportList = [];

  List heartrateArray = [];
  List tempArray = [];
  List<String> oxygenArray = [];
  List lipidArray = [];
  List bloodLvlArray = [];

  String tempResult;
  String heartRateResult;
  String oxygenResult;
  String regNo = "9121389950648015";

  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups = [];
  var blood1;
  var blood2;
  var visittype;

  @override
  void initState() {
    super.initState();
    //healthChartResponse = widget.model.healthChartResponse;
    callApi(regNo);
  }

  callApi(String regNo) {
    print('--------------  ' + regNo);
    setState(() {
      widget.model.GETMETHODCAL(
          api: ApiFactory.HEALTH_CHART + regNo,
          fun: (Map<String, dynamic> map) async {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              healthChartResponse = HealthChartResponse.fromJson(map);
              reportResponse = healthChartResponse.screeningReport;
              bloodlevelResponse = healthChartResponse.bloodlevel;
              oxygenResponse = healthChartResponse.oximeter;

              print('Oximeter -------- ' +
                  healthChartResponse.oximeter.toString());

              setState(() {
                for (int i = 0; i < reportResponse.length; i++) {
                  tempResult = reportResponse[i].temp;
                  tempArray.add(reportResponse[i].tempFrmRange);
                  tempArray.add(tempResult);
                  tempArray.add(reportResponse[i].tempToRange);

                  oxygenResult = oxygenResponse[i].spo2;
                  oxygenArray.add(oxygenResponse[i].spo2FrmRange);
                  oxygenArray.add(oxygenResult);
                  oxygenArray.add(oxygenResponse[i].spo2ToRange);

                  print('======================== ' + oxygenArray.toString());

                  heartRateResult = reportResponse[i].heartRate;
                  heartrateArray.add(reportResponse[i].heartRateFrmRange);
                  heartrateArray.add(heartRateResult);
                  heartrateArray.add(reportResponse[i].heartRateToRange);

                  if (i == 0) {
                    FlSpot flSpot = new FlSpot(
                        0,
                        double.parse(
                            heartrateArray[i] == "" ? "0" : heartrateArray[i]));
                    heartrateList.add(flSpot);

                    FlSpot flSpot3 = new FlSpot(94.0, 97.0);
                    oxygenList.add(flSpot3);

                    print('-------heartrateList------' +
                        heartrateList.toString());
                  } else {
                    FlSpot flSpot1 = new FlSpot(
                        double.parse(heartrateArray[i - 1].toString()),
                        double.parse(heartrateArray[i].toString()));
                    heartrateList.add(flSpot1);

                    FlSpot flSpot3 = new FlSpot(97.0, 100.0);
                    oxygenList.add(flSpot3);
                  }

                  // blood1 = reportResponse[i].heartRate.toString();
                  // blood2 = reportResponse[i].heartRate.toString();

                  // bloodLvlArray.add(bloodlevelResponse[i].hemo);
                  //  bloodLvlArray.add(bloodlevelResponse[i].mch);
                  //  bloodLvlArray.add(bloodlevelResponse[i].mchc);
                  //   bloodLvlArray.add(bloodlevelResponse[i].mcv);
                  //   bloodLvlArray.add(bloodlevelResponse[i].pcv);
                  //    bloodLvlArray.add(bloodlevelResponse[i].rbc);

                  //    print('BLOODLEVEL------ ' + bloodLvlArray.toString());

                  //         visittype = reportResponse[i].visitingType;
                  //         visittype = [i+1];

                  //         BarChartGroupData barchart = new BarChartGroupData(x: int.tryParse(visittype),
                  //         showingTooltipIndicators: [0,1],
                  //         barsSpace: 10,
                  //         barRods: [
                  //            BarChartRodData(
                  //   y: double.tryParse(blood1),
                  //   colors: [Colors.lightBlueAccent, Colors.greenAccent],
                  //   width: width,
                  // ),
                  // BarChartRodData(
                  //   y: double.tryParse(blood2),
                  //   colors: [rightBarColor],
                  //   width: width,
                  // ),
                  //         ]
                  //         );
                  //         showingBarGroups.add(barchart);

                }
                // heartrateArray.sort();
                //  oxygenArray.sort();
              });
            } else {
              //AppData.showIn//SnackBar(context, map[Const.MESSAGE]);
              // AppData.showInSnackBar(
              //     context, "No Data");
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("HEALTH_CHART"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(children: [
                Expanded(
                    child: oxygenResponse.isNotEmpty
                        ? _buildTile(
                            icon: "",
                            title: "Oxygen Level",
                            fun: () {
                              // Navigator.pushNamed(context, "/testreport");
                            },
                            text: oxygenResult.toString() + ' C',
                            image:
                                'https://ma-hub.imgix.net/wp-images/2019/06/02182647/after-effects-line-graph.jpg',
                            list: demoList,
                            minX: 0,
                            maxX: 94,
                            minY: 0,
                            maxY: 100
                            // minX:0,
                            // maxX:0,
                            // minY:0,
                            // maxY:0
                            )
                        : _buildNullTile(
                            icon: "",
                            title: "Temperature",
                            fun: () {
                              // Navigator.pushNamed(context, "/testreport");
                            },
                            text: '0.0 C',
                            image:
                                'https://ma-hub.imgix.net/wp-images/2019/06/02182647/after-effects-line-graph.jpg',
                            list: tempList,
                          )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: reportResponse.isNotEmpty
                        ? _buildTile(
                            icon: "assets/contrast.png",
                            title: "Heart Rate",
                            fun: () {
                              // Navigator.pushNamed(context, "/dashboardusernew");
                            },
                            text: heartRateResult + ' mmHG',
                            image:
                                'https://ma-hub.imgix.net/wp-images/2019/06/02182647/after-effects-line-graph.jpg',
                            // size: (size.width - 42) / 2),
                            list: heartrateList,
                            minX: double.parse(heartrateArray[0] == ""
                                ? "0"
                                : heartrateArray[0].toString()),
                            maxX: double.parse(heartrateArray[2] == ""
                                ? "0"
                                : heartrateArray[1].toString()),
                            minY: double.parse(heartrateArray[0] == ""
                                ? "0"
                                : heartrateArray[0].toString()),
                            maxY: double.parse(heartrateArray[2] == ""
                                ? "0"
                                : heartrateArray[1].toString()))
                        : _buildNullTile(
                            icon: "",
                            title: "Heart Rate",
                            fun: () {
                              // Navigator.pushNamed(context, "/testreport");
                            },
                            text: '0.0 C',
                            image:
                                'https://ma-hub.imgix.net/wp-images/2019/06/02182647/after-effects-line-graph.jpg',
                            list: heartrateList,
                          )),
              ]),

              SizedBox(
                height: size.height * 0.01,
              ),
              _electrolyteTile(
                icon: "",
                title: "Electrolyte Moth of June",
                fun: () {
                  // Navigator.pushNamed(context, "/testreport");
                },
                image:
                    'https://ma-hub.imgix.net/wp-images/2019/06/02182647/after-effects-line-graph.jpg',
                // list: demoList,
                //   minX:0,
                //   maxX:94,
                //   minY:0,
                //   maxY: 100
                // minX:0,
                // maxX:0,
                // minY:0,
                // maxY:0
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              _hematoTile(
                title: "Hematology",
                fun: () {
                  // Navigator.pushNamed(context, "/dashboardusernew");
                },
                image:
                    'https://www.thinkoutsidetheslide.com/wp-content/uploads/2019/09/Default-legend.jpg',
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
//                Container(
//                 height: 250,
//                 // color: Colors.white,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   children: [
//         //          Container(
//         //       // height: 150,
//         //         decoration: BoxDecoration(
//         //   borderRadius: BorderRadius.circular(10.0),
//         //   color: Colors.white,
//         // ),
//         //       child:
//         //        Padding(
//         //          padding: const EdgeInsets.all(15.0),
//         //          child: LineChart(
//         //           LineChartData(
//         //             lineTouchData: LineTouchData(enabled: true),
//         //            borderData: FlBorderData(
//         //         show: false,
//         //       ),
//         //             lineBarsData: [
//         //               LineChartBarData(
//         //                 spots: [
//         //                   FlSpot(0, 4),
//         //                   FlSpot(1, 3.5),
//         //                   FlSpot(2, 4.5),
//         //                 ],
//         //                 isCurved: true,
//         //                 barWidth: 2,
//         //                 colors: [
//         //                   Colors.green,
//         //                 ],
//         //                 dotData: FlDotData(
//         //                   show: true,
//         //                 ),
//         //               ),
//         //               LineChartBarData(
//         //                 spots: [
//         //                   FlSpot(0, 7.8),
//         //                   FlSpot(7.8, 10.2),
//         //                   FlSpot(10.2, 10.9)
//         //                 ],
//         //                 isCurved: true,
//         //                 barWidth: 2,
//         //                 colors: [
//         //                   Colors.greenAccent,
//         //                 ],
//         //                 dotData: FlDotData(
//         //                   show: true,
//         //                 ),
//         //               ),
//         //               LineChartBarData(
//         //                 spots: [
//         //                   FlSpot(0, 1.9),
//         //                   FlSpot(1.9, 2.2),
//         //                   FlSpot(2.2, 2.7)
//         //                 ],
//         //                 isCurved: true,
//         //                 barWidth: 2,
//         //                 colors: [
//         //                   Colors.red,
//         //                 ],
//         //                 dotData: FlDotData(
//         //                   show: true,
//         //                 ),
//         //               ),
//         //             ],
//         //             betweenBarsData: [
//         //               BetweenBarsData(
//         //                 fromIndex: 0,
//         //                 toIndex: 2,
//         //                 colors: [Colors.transparent],
//         //               )
//         //             ],
//         //             minY: 0,
//         //             titlesData: FlTitlesData(
//         //               bottomTitles: SideTitles(
//         //                   showTitles: true,
//         //                   getTextStyles: (value) => const TextStyle(
//         //                       fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
//         //                   getTitles: (value) {
//         //                     switch (value.toInt()) {
//         //                       case 0:
//         //                         return 'Jan';
//         //                       case 1:
//         //                         return 'Feb';
//         //                       case 2:
//         //                         return 'Mar';
//         //                       case 3:
//         //                         return 'Apr';
//         //                       case 4:
//         //                         return 'May';
//         //                       default:
//         //                         return '';
//         //                     }
//         //                   }),
//         //               leftTitles: SideTitles(
//         //                 showTitles: false,
//         //               ),
//         //             ),
//         //             gridData: FlGridData(
//         //               show: false,
//         //             ),
//         //           ),
//         //       ),
//         //        ),
//         //     ),

//            Container(
//              color: Colors.red,
//              width: 100,
//            ),
//            Container(
//              width: 100,
//              color: Colors.red,
//            )
//                     // Image.asset("assets/health/8.png"),
//                     // Image.asset("assets/health/11.png"),
//                   ],
//                 ),
//               ),
//  SizedBox(
//                 height: size.height * 0.01,
//               ),
              _kidneyTile(
                title: "Kidney Function Test",
                fun: () {
                  // Navigator.pushNamed(context, "/dashboardusernew");
                },
                image:
                    'https://www.thinkoutsidetheslide.com/wp-content/uploads/2019/09/Default-legend.jpg',
              ),
              SizedBox(
                height: 10,
              ),
              _lipidTile(
                title: "Lipid Profile".toString(),
                fun: () {
                  // Navigator.pushNamed(context, "/dashboardusernew");
                },
                image:
                    'https://www.thinkoutsidetheslide.com/wp-content/uploads/2019/09/Default-legend.jpg',
              ),
              SizedBox(
                height: 10,
              ),
              _bodyAnalyzerTile(
                title: "Body Analyzer".toUpperCase(),
                fun: () {
                  // Navigator.pushNamed(context, "/dashboardusernew");
                },
                image:
                    'https://www.thinkoutsidetheslide.com/wp-content/uploads/2019/09/Default-legend.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNullTile(
      {String icon,
      String title,
      String text,
      String image,
      List list,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Monte",
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Monte",
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 50,
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: 0,
                          minY: 0,
                          maxY: 0,
                          // titlesData: LineTitles.getTitleData(),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 0.0,
                              );
                            },
                            drawVerticalLine: true,
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 0.0,
                              );
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: list,
                              isCurved: true,
                              colors: gradientline,
                              barWidth: 1,
                              isStrokeCapRound: true,
                              // dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 15,
                right: 15,
                child: Image.asset(
                  icon,
                  height: 10,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Future getCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(_path));

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);

      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
    }
  }

  Container _buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      // height: 230.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                )),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 83,
                width: 83,
                child: Stack(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (pathUsr != null)
                        ? Material(
                            elevation: 5.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: FileImage(pathUsr),
                            ),
                          )
                        : Material(
                            elevation: 5.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                                  NetworkImage(AppData.defaultImgUrl),
                            ),
                          ),
                    //(loginResponse.ashadtls[0].userType.toLowerCase() == "user")
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          getCameraImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: AppData.matruColor,
                        ),
                      ),
                    )
                    // : Container()
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Name : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            "IPSITA ",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Register Id : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            "9121389950648015",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Role : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            "USER",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Phone : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            "8249514637",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Address : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            "BHUBANESWAR",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Weight : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            '50',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Height : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            '5.5',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      // SizedBox(height: size.height * 0.01),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initUniqueIdentifierState() async {
    if (Platform.isAndroid) {
      MyWidgets.showLoading(context);
      String identifier;
      try {
        identifier = await UniqueIdentifier.serial;
        if (identifier != null) {
          Map<String, dynamic> postData = {
            "apid": Const.APP_ID,
            "deviceId": identifier,
            "action": "remove"
          };
          widget.model.POSTMETHOD(
            api: ApiFactory.REG_DEVICE,
            json: postData,
            fun: (Map<String, dynamic> map) {
              if (map["code"] == 200) {
                AppData.showInSnackDone(context, map["msg"] ?? "Offline");
                //if (map["msg"] == "device id added") {
                sharedPref.save(Const.IS_REG_SERVER, "false");
                _exitApp();
                //}
              } else {
                AppData.showInSnackBar(context, map["msg"] ?? "Offline");
              }
            },
          );
        }
      } on PlatformException {
        identifier = 'Failed to get Unique Identifier';
      }
      if (!mounted) return;
    } else {
      _exitApp();
    }
  }

  _exitApp() async {
    sharedPref.save(Const.IS_LOGIN, false.toString());
    sharedPref.save(Const.IS_REGISTRATION, false.toString());
    sharedPref.remove(Const.IS_REGISTRATION);
    sharedPref.remove(Const.IS_LOGIN);
    sharedPref.remove(Const.LOGIN_DATA);
    sharedPref.remove(Const.IS_REG_SERVER);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login1', (Route<dynamic> route) => false);
  }

  Widget _buildTile(
      {String icon,
      String title,
      String text,
      String image,
      double minX,
      double minY,
      double maxX,
      double maxY,
      List list,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Monte",
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Monte",
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 50,
                      child: LineChart(
                        LineChartData(
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                          // titlesData: LineTitles.getTitleData(),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 0.0,
                              );
                            },
                            drawVerticalLine: true,
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 0.0,
                              );
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: list
                              //                   [
                              //                     FlSpot(0, 3),
                              // FlSpot(2.6, 2),
                              // FlSpot(4.9, 5),
                              // FlSpot(6.8, 3.1),
                              // FlSpot(8, 4),
                              // FlSpot(9.5, 3),
                              // FlSpot(11, 4),
                              //                   ]
                              ,
                              isCurved: true,
                              colors: gradientline,
                              barWidth: 1,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: false,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 15,
                right: 15,
                child: Image.asset(
                  icon,
                  height: 10,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _electrolyteTile(
      {String icon, String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        // height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: AspectRatio(
                  aspectRatio: 5.2,
                  child: LineChart(
                    LineChartData(
                      // maxX: 15,
                      lineTouchData: LineTouchData(
                        enabled: true,
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(0, 0),
                            FlSpot(0, 0),
                          ],
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.transparent,
                          ],
                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 7.8),
                            FlSpot(7.8, 10.2),
                            FlSpot(10.2, 10.9)
                          ],
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.black54,
                          ],
                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1.9),
                            FlSpot(1.9, 2.2),
                            FlSpot(2.2, 2.7)
                          ],
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.green,
                          ],
                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                      betweenBarsData: [
                        BetweenBarsData(
                          fromIndex: 0,
                          toIndex: 2,
                          colors: [Colors.transparent],
                        )
                      ],
                      minY: 0,
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 6,
                            getTextStyles: (context,double) => const TextStyle(
                                fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 0:
                                  return 'Week1 ';
                                case 1:
                                  return 'Week2';
                                case 2:
                                  return 'Week3';
                                case 3:
                                  return 'Week4';
                                case 4:
                                  return 'Week5';
                                default:
                                  return '';
                              }
                            }),
                        leftTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      gridData: FlGridData(
                        show: false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyactivityTile(
      {String title,
      String text,
      String detectText,
      String image,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height * 0.23,
        width: (MediaQuery.of(context).size.width - 22) / 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppData.matruColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Monte",
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(color: Colors.red[900]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                          ),
                        ),
                      )),
                  Spacer(),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        detectText,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.clip,
                        maxLines: 4,
                      ))
                ],
              ),
              Image.asset(
                image, fit: BoxFit.cover,
                //  height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _hematoTile({String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        //height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (healthChartResponse != null)
                  ? showHematoChart(healthChartResponse.bloodlevel)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sugTile({String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        //height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (healthChartResponse != null)
                  ? shChart(healthChartResponse.bloodlevel)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kidneyTile({String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        //height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (healthChartResponse != null)
                  ? showKidneyChart(healthChartResponse.bloodlevel)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lipidTile({String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        //height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (healthChartResponse != null)
                  ? showLipidProfile(healthChartResponse.bloodlevel)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyAnalyzerTile({String title, String image, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        //height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Monte",
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (healthChartResponse != null)
                  ? bodyAnalyzer(healthChartResponse.bloodlevel)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  showHematoChart(List<Bloodlevel> bloodlvl) {
    return Padding(
      padding: const EdgeInsets.only(top: 110.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 15,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.white,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.toString(),
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,

                  getTextStyles: (context,double) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'HEMO';
                      case 1:
                        return 'MCH';
                      case 2:
                        return 'MCHC';
                      case 3:
                        return 'MCV';
                      case 4:
                        return 'PCV';
                      case 5:
                        return 'RBC';
                      /*case 6:
                      return 'Sn';*/
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse((13.3).toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(30.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(33.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(90.7.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(39.9.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(4.4.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  lipidChart(reportResponse) {
    return Padding(
      padding: const EdgeInsets.only(top: 110.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: BarChart(
            BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 30,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
                    tooltipMargin: 8,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.y.toString(),
                        TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context,double) => const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    margin: 20,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Hdl';
                        case 1:
                          return '1';
                        case 2:
                          return '2';
                        case 3:
                          return '3';
                        case 4:
                          return '4';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups),
          ),
        ),
      ),
    );
  }

  showKidneyChart(List<Bloodlevel> bloodlvl) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.toString(),
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  rotateAngle: -20,
                  getTextStyles: (context,double) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'creatinine'.toUpperCase();
                      case 1:
                        return 'estdGlomu..'.toUpperCase();
                      case 2:
                        return 'ureakin'.toUpperCase();
                      case 3:
                        return 'ureabun'.toUpperCase();
                      case 4:
                        return 'uricacid'.toUpperCase();
                      /*case 6:
                      return 'Sn';*/
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse((13.3).toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(30.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(33.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(90.7.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(39.9.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 25,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shChart(List<Bloodlevel> bloodlvl) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: true),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 4),
                      FlSpot(1, 3.5),
                      FlSpot(2, 4.5),
                    ],
                    isCurved: true,
                    barWidth: 2,
                    colors: [
                      Colors.green,
                    ],
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 7.8),
                      FlSpot(7.8, 10.2),
                      FlSpot(10.2, 10.9)
                    ],
                    isCurved: true,
                    barWidth: 2,
                    colors: [
                      Colors.greenAccent,
                    ],
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                  LineChartBarData(
                    spots: [FlSpot(0, 1.9), FlSpot(1.9, 2.2), FlSpot(2.2, 2.7)],
                    isCurved: true,
                    barWidth: 2,
                    colors: [
                      Colors.red,
                    ],
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                ],
                betweenBarsData: [
                  BetweenBarsData(
                    fromIndex: 0,
                    toIndex: 2,
                    colors: [Colors.transparent],
                  )
                ],
                minY: 0,
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context,double) => const TextStyle(
                          fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Feb';
                          case 2:
                            return 'Mar';
                          case 3:
                            return 'Apr';
                          case 4:
                            return 'May';
                          default:
                            return '';
                        }
                      }),
                  leftTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                gridData: FlGridData(
                  show: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLipidProfile(List<Bloodlevel> bloodlvl) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.toString(),
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  rotateAngle: -20,
                  getTextStyles: (context,double) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'cholestrol'.toUpperCase();
                      case 1:
                        return 'hdl'.toUpperCase();
                      case 2:
                        return 'ldl'.toUpperCase();
                      case 3:
                        return 'triglyceride'.toUpperCase();
                      /*case 6:
                      return 'Sn';*/
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse((13.3).toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(30.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(33.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(90.7.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bodyAnalyzer(List<Bloodlevel> bloodlvl) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: AspectRatio(
        aspectRatio: 5.2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          // color: const Color(0xFF2E537C),
          color: Colors.white,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.toString(),
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  rotateAngle: -20,
                  getTextStyles: (context,double) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'cholestrol'.toUpperCase();
                      case 1:
                        return 'hdl'.toUpperCase();
                      case 2:
                        return 'ldl'.toUpperCase();
                      case 3:
                        return 'triglyceride'.toUpperCase();
                      /*case 6:
                      return 'Sn';*/
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse((13.3).toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(30.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(33.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                        y: double.tryParse(90.7.toString()),
                        borderRadius: const BorderRadius.all(Radius.zero),
                        width: 15,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent
                        ])
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
