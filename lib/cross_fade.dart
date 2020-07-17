import 'package:flutter/material.dart';

class CrossFade extends StatefulWidget {
  @override
  _CrossFadeState createState() => _CrossFadeState();
}

class _CrossFadeState extends State<CrossFade> {
  bool _first = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          AnimatedCrossFade(
            duration: const Duration(seconds: 3),
            firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
            secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
            crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          RaisedButton(
            onPressed: () => setState(() {
              if(_first)
                _first = false;
              else
                _first = true;
            }),
            child: Text('Click'),
          )
        ],
      ),
    );
  }
}
