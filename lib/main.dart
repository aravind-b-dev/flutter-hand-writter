import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new SplashScreens(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreens extends StatelessWidget {
  const SplashScreens({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      image: new Image.asset('assets/images/hand.png'),
      gradientBackground: LinearGradient(
        begin: Alignment(0.5, -.5),
        end: Alignment(0.5, 1.0),
        colors: [
          Colors.teal.shade400,
          Colors.teal.shade600,
          Colors.teal.shade800,
          Colors.teal.shade900,
        ],
      ),
      photoSize: 120.0,
      loaderColor: Colors.white,
      navigateAfterSeconds: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        elevation: 5,
        // backgroundColor: Colors.transparent.withAlpha(20),
        backgroundColor: Colors.teal.shade600,
        title: Text("Handwrite"),
        centerTitle: true,
      ),
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
              object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.teal,
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.teal
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}