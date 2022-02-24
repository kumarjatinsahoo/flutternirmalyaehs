import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsPage extends StatefulWidget {
  final MainModel model;

  const VideoDetailsPage({Key key, this.model}) : super(key: key);

  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  String block =
      "<blockquote><h1>Words can be like X-rays, if you use them properly—they’ll go through anything. You read and you’re pierced.</h1></blockquote><figcaption>—Aldous Huxley, <cite>Brave New World</cite></figcaption>";

  String videoUrl;

  /*=
      // "https://turneradstoedc.akamaized.net/m/1/48804/20/9010068/Kerala_Tourism_-_Family_-_30_SEC_1.0_1609754475_2608114_523.mp4";
      // "https://videos-cloudflare.jwpsrv.com/6187c5f2_510fd4a2ae0c6959532417db2481814ba7814609/content/conversions/wPTWN2YS/videos/6pw4jzx8-31875107.mp4";
      "https://content.jwplatform.com/videos/6pw4jzx8-z057noEQ.mp4";
*/
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  ScrollController _scrollControl;

  TextDirection currentDirection;
  bool isRTL = false;

  @override
  void initState() {
    // TODO: implement initState
    // isRTL = (AppData.selectedLanguage == "English") ? false : true;
    videoUrl =widget.model.pdfurl;
    _scrollControl = ScrollController();
    _scrollControl.addListener(() {
      if (_scrollControl.position.pixels > 400) {
        _chewieController.pause();
      }
    });

    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(videoUrl);

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    // _controller.dispose();
    _videoPlayerController1.dispose();
    if(_chewieController!=null)
    _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double padding = 25;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //key: scafoldKey,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.cancel_sharp,
            size: 33,
            color: Colors.grey,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Navigator.pop(context);
            //_chewieController.pause();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: ListView(
          children: [
            Container(
              // padding: EdgeInsets.only(bottom: 70),
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: _chewieController != null &&
                                _chewieController
                                    .videoPlayerController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController1.value.aspectRatio,
                                child: Chewie(
                                  controller: _chewieController,
                                ),
                              )
                            : Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CupertinoActivityIndicator(),
                                    SizedBox(height: 20),
                                    Text('Loading'),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewRich(val1, val2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          // style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: val1 + ". ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                    fontSize: 35,
                    color: Colors.pink)),
            TextSpan(
              text: val2,
              style: TextStyle(
                  fontFamily: "DIN Alternate",
                  fontSize: 26,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
