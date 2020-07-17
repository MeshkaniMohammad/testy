
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


const kMinScrollBarHeight = 20.0;

class MyScreen extends StatefulWidget {
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  double _scrollBarOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 23, 35, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 72, 18, 1.0),
      ),
      body: Stack(children: <Widget>[
        GestureDetector(
          onVerticalDragUpdate: (tapDetails) =>
            setState(() => _scrollBarOffset = tapDetails.globalPosition.dy),
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(
                  'My screen widgets',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    bottom: MediaQuery.of(context).size.height -
                      max(
                        _scrollBarOffset,
                        MediaQuery.of(context).padding.top +
                          kToolbarHeight +
                          kMinScrollBarHeight),
                    child: CustomPaint(
                      painter: MyDraggable(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlutterLogo(
                              size: 100.0,
                            ),
                            Text('Flutter is awesome'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class MyDraggable extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;
    final Radius cornerRadius = Radius.circular(20.0);
    final double lineMargin = 30.0;

    // Draw slider
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(0.0, 0.0, size.width, size.height,
        bottomLeft: cornerRadius, bottomRight: cornerRadius),
      paint);
    paint.color = Colors.black.withAlpha(64);
    paint.strokeWidth = 1.5;

    // Draw triangle
    canvas.drawPoints(
      PointMode.polygon,
      [
        Offset((size.width / 2) - 5.0, size.height - 10.0),
        Offset((size.width / 2) + 5.0, size.height - 10.0),
        Offset((size.width / 2), size.height - 5.0),
        Offset((size.width / 2) - 5.0, size.height - 10.0),
      ],
      paint);

    // Draw line
    canvas.drawLine(Offset(lineMargin, size.height - kMinScrollBarHeight),
      Offset(size.width - lineMargin, size.height - kMinScrollBarHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}