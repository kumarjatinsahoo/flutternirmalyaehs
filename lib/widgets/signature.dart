import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// class Signature extends StatefulWidget {
//   Signature({Key key}) : super(key: key);

//   @override
//   _SignatureState createState() => _SignatureState();
// }

// class _SignatureState extends State<Signature> {
//   List<Offset> _points = <Offset>[];

//   Future<ui.Image> get rendered {
//     // [CustomPainter] has its own @canvas to pass our
//     // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
//     // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
//     // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
//     // with the our newly created @canvas
//     ui.PictureRecorder recorder = ui.PictureRecorder();
//     Canvas canvas = Canvas(recorder);
//     SignaturePainter painter = SignaturePainter(points: _points);
//     var size = context.size;
//     painter.paint(canvas, size);
//     return recorder
//         .endRecording()
//         .toImage(size.width.floor(), size.height.floor());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: new AppBar(
//       //   title: const Text('Signature'),
//       //   actions: [
//       //     new FlatButton(
//       //         onPressed: () {
//       //           Navigator.of(context).pop("signature");
//       //         },
//       //         child: new Text('SAVE',
//       //             style: Theme.of(context)
//       //                 .textTheme
//       //                 .subhead
//       //                 .copyWith(color: Colors.white))),
//       //   ],
//       // ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.red,
//             width: MediaQuery.of(context).size.width,
//             height: 100.0,
//             child: Center(
//               child: Text(
//                 "Home",
//                 style: TextStyle(color: Colors.white, fontSize: 18.0),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             child: GestureDetector(
//               onPanUpdate: (DragUpdateDetails details) {
//                 setState(() {
//                   RenderBox _object = context.findRenderObject();
//                   Offset _locationPoints =
//                       _object.localToGlobal(details.globalPosition);
//                   _points = new List.from(_points)..add(_locationPoints);
//                 });
//               },
//               onPanEnd: (DragEndDetails details) {
//                 setState(() {
//                   _points.add(null);
//                 });
//               },
//               child: CustomPaint(
//                 painter: SignaturePainter(points: _points),
//                 size: Size.infinite,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignaturePainter extends CustomPainter {
//   // [SignaturePainter] receives points through constructor
//   // @points holds the drawn path in the form (x,y) offset;
//   // This class responsible for drawing only
//   // It won't receive any drag/touch events by draw/user.
//   List<Offset> points = <Offset>[];

//   SignaturePainter({this.points});
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.square
//       ..strokeWidth = 5.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(SignaturePainter oldDelegate) {
//     return oldDelegate.points != points;
//   }
// }

class Signature1 extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final CustomPainter backgroundPainter;
  final Function onSign;

  Signature1({
    this.color = Colors.black,
    this.strokeWidth = 5.0,
    this.backgroundPainter,
    this.onSign,
    Key key,
  }) : super(key: key);

  Signature1State createState() => Signature1State();

  static Signature1State of(BuildContext context) {
    return context.findAncestorStateOfType<Signature1State>();
  }
}

class _SignaturePainter extends CustomPainter {
  final double strokeWidth;
  final List<Offset> points;
  final Color strokeColor;
  Paint _linePaint;

  _SignaturePainter(
      {@required this.points,
      @required this.strokeColor,
      @required this.strokeWidth}) {
    _linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], _linePaint);
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter other) => other.points != points;
}

class Signature1State extends State<Signature1> {
  List<Offset> _points = <Offset>[];
  _SignaturePainter _painter;
  Size _lastSize;

  Signature1State();

  void _onDragStart(DragStartDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPostion = referenceBox.globalToLocal(details.globalPosition);
    setState(() {
      _points = List.from(_points)..add(localPostion)..add(localPostion);
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

    setState(() {
      _points = List.from(_points)..add(localPosition);
      if (widget.onSign != null) {
        widget.onSign();
      }
    });
  }

  void _onDragEnd(DragEndDetails details) => _points.add(null);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    _painter = _SignaturePainter(
        points: _points,
        strokeColor: widget.color,
        strokeWidth: widget.strokeWidth);
    return ClipRect(
      child: CustomPaint(
        painter: widget.backgroundPainter,
        foregroundPainter: _painter,
        child: GestureDetector(
            onVerticalDragStart: _onDragStart,
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            onPanStart: _onDragStart,
            onPanUpdate: _onDragUpdate,
            onPanEnd: _onDragEnd),
      ),
    );
  }

  Future<ui.Image> getData() {
    var recorder = ui.PictureRecorder();
    var origin = Offset(0.0, 0.0);
    var paintBounds = Rect.fromPoints(
        _lastSize.topLeft(origin), _lastSize.bottomRight(origin));
    var canvas = Canvas(recorder, paintBounds);
    if (widget.backgroundPainter != null) {
      widget.backgroundPainter.paint(canvas, _lastSize);
    }
    _painter.paint(canvas, _lastSize);
    print(_lastSize.width.round());
    var picture = recorder.endRecording();
    return picture.toImage(_lastSize.width.round(), _lastSize.height.round());
  }

  void clear() {
    setState(() {
      _points = [];
    });
  }

  bool get hasPoints => _points.length > 0;

  List<Offset> get points => _points;

  afterFirstLayout(BuildContext context) {
    _lastSize = context.size;
  }
}
