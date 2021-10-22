import 'package:carousel_slider/carousel_slider.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class OrganDonation extends StatefulWidget {
  MainModel model;

  OrganDonation({Key key, this.model}) : super(key: key);

  @override
  _OrganDonationState createState() => _OrganDonationState();
}

class _OrganDonationState extends State<OrganDonation> {


  List<String> imageSliders = [
    "assets/intro/organBanner1.jpg",
    "assets/intro/organBanner2.jpeg",
    "assets/intro/organbanner3.jpeg",
  ];
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Organ Donation',
          style: TextStyle(
              fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        Navigator.pushNamed(context, "/organ1");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/intro/organ1.jpeg',
                            width: 102,
                            height: 102,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'What is Organ\nDonation?',
                            // 'What is Organ Donation?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        Navigator.pushNamed(context, "/organ2");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/intro/organ2.jpeg',
                            width: 102,
                            height: 102,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Who Can Donate?\n',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        Navigator.pushNamed(context, "/organ3");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/intro/organ3.jpeg',
                            width: 102,
                            height: 102,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Which Organs?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        Navigator.pushNamed(context, "/organ4");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/intro/oragan4.jpeg',
                            width: 102,
                            height: 102,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How to Donate?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20,right: 20, top: 40),
                child: _applicationButton(),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 210,
                          autoPlay: true,
                          pageSnapping: true,
                          viewportFraction: 1,
                          scrollDirection: Axis.horizontal,
                          disableCenter: true,
                          autoPlayInterval: Duration(seconds: 10),
                          //autoPlayAnimationDuration: Duration(seconds: 90),
                          pauseAutoPlayInFiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(
                                  () {
                                _currentIndex = index;
                              },
                            );
                          }),
                      items: imageSliders
                          .map((item) => InkWell(
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    item,
                                    fit: BoxFit.fill,
                                    width: 1000,
                                    height: double.maxFinite,
                                    //height: 100,
                                  ),
                                  /* Image.network(
                                               item.bannerImage,
                                               fit: BoxFit.fill,
                                               width: 1000,
                                               height: double.maxFinite,
                                             ),*/

                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (imageSliders.indexOf(item) + 1)
                                                .toString() +
                                                "/" +
                                                imageSliders.length
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /*Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: (imageSliders.indexOf(item) == 4 ||
                                        imageSliders.indexOf(item) == 7 ||
                                        imageSliders.indexOf(item) == 0 ||
                                        imageSliders.indexOf(item) == 1 ||
                                        imageSliders.indexOf(item) == 9 ||
                                        imageSliders.indexOf(item) == 10)
                                        ? Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 45,
                                    )
                                        : Container(),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _applicationButton() {
    return MyWidgets.nextButton(
      text: "Application",
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        Navigator.pushNamed(context, "/donorApplication");

        //}
      },
    );
  }
}
