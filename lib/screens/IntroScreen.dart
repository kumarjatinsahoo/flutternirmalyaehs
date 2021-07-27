import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/app_data.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  Function goToTab;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "ALL YOUR MEDICAL NEEDS IN",
        styleTitle:
            TextStyle(color: Colors.black, fontFamily: "Monte", fontSize: 15),
        styleDescription: TextStyle(
          color: Colors.black,
          fontFamily: "MonteMed",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        description: "ONE PLACE",
        pathImage: "assets/intro/intro1.png",
        backgroundColor: AppData.BG1RED,
      ),
    );
    slides.add(
      new Slide(
        title: "FIND DOCTORS NEAR BY TO YOUR LOCATION",
        styleTitle:
            TextStyle(color: Colors.black, fontFamily: "Monte", fontSize: 15),
        styleDescription: TextStyle(
          color: Colors.black,
          fontFamily: "MonteMed",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        description: "WITHIN SECONDS",
        pathImage: "assets/intro/intro2.png",
        backgroundColor: AppData.BG2BLUE,
      ),
    );
    slides.add(
      new Slide(
        title: "THE POWERFUL MAP VIEW",
        styleDescription:
            TextStyle(color: Colors.black, fontFamily: "Monte", fontSize: 15),
        styleTitle: TextStyle(
          color: Colors.black,
          fontFamily: "MonteMed",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        description:
            "ENABLE YOU TO LOCATE DOCTORS,CLINICS & PHARMACIES WITH EASE",
        pathImage: "assets/intro/intro3.png",
        backgroundColor: AppData.BG1RED,
      ),
    );
    slides.add(
      new Slide(
        title: "OUR MEDICAL DATA KEEP IN",
        styleTitle:
            TextStyle(color: Colors.black, fontFamily: "Monte", fontSize: 15),
        styleDescription: TextStyle(
          color: Colors.black,
          fontFamily: "MonteMed",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        description: "HIGH SECURITY SYSTEM",
        pathImage: "assets/intro/intro4.png",
        backgroundColor: AppData.BG2BLUE,
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    //this.goToTab(0);
    sharedPref.save('first_time', "false");
    Navigator.pushNamed(context, "/login");
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    print(index);
  }

  Widget renderNextBtn() {
    /*return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );*/
    return Text("NEXT", style: TextStyle(color: Colors.black));
  }

  Widget renderDoneBtn() {
    /*return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );*/
    return Text("DONE", style: TextStyle(color: Colors.black));
  }

  Widget renderSkipBtn() {
    /*return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );*/
    return Text(
      "SKIP",
      style: TextStyle(color: Colors.black),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33ffcc5c)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> renderListCustomTabs() {
      List<Widget> tabs = [];
      for (int i = 0; i < slides.length; i++) {
        Slide currentSlide = slides[i];
        tabs.add(Container(
          color: currentSlide.backgroundColor,
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Image.asset(
                  currentSlide.pathImage,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFD8ABAF),
                      width: 1.0, // Underline thickness
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ));
      }
      return tabs;
    }

    return new IntroSlider(
      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      //skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      //nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      // doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Colors.grey,
      sizeDot: 8.0,
      colorActiveDot: Colors.black,
      //typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
