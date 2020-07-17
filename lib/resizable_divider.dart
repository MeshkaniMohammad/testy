

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Orientation _orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: <Widget>[
          ExpandableWidget(
            maxWidth: MediaQuery.of(context).size.width ,
            width: _width < 500 || _orientation == Orientation.landscape
                ? 40
                : MediaQuery.of(context).size.width / 3,
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              if(_orientation == Orientation.landscape)
              return Container(
                color: Colors.blue,
              );
              return Container(color: Colors.green,);
            }),
          ),
          ExpandableWidget(
            maxWidth: MediaQuery.of(context).size.width ,
            width: _width < 500 || _orientation == Orientation.landscape
              ? 40
              : MediaQuery.of(context).size.width / 3,
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              if(_orientation == Orientation.landscape)
                return Container(
                  color: Colors.blue,
                );
              return Container(color: Colors.green,);
            }),
          ),
          ExpandableWidget(
            maxWidth: MediaQuery.of(context).size.width ,
            width: _width < 500 || _orientation == Orientation.landscape
              ? 40
              : MediaQuery.of(context).size.width / 3,
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              if(_orientation == Orientation.landscape)
                return Container(
                  color: Colors.blue,
                );
              return Container(color: Colors.green,);
            }),
          )
        ],
      ),
    );
  }
}



class ExpandableWidget extends StatefulWidget {
  final double width;
  final double maxWidth;
  final double dividerHeight;
  final double dividerSpace;
  final Widget child;

  const ExpandableWidget({
    Key key,
    @required this.child,
    this.width = 44,
    @ required this.maxWidth,
    this.dividerHeight = 20,
    this.dividerSpace = 2,
  }) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  double _width, _maxWidth, _dividerHeight, _dividerSpace;

  @override
  void initState() {
    super.initState();
    _width = widget.width;
    _maxWidth = widget.maxWidth;
    _dividerHeight = widget.dividerHeight;
    _dividerSpace = widget.dividerSpace;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: _maxWidth,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _width,
            child: widget.child,
          ),
          //SizedBox(height: _dividerSpace),
          GestureDetector(
            child: Container(
              width: 20,
              color: Colors.red,
            ),
            onPanUpdate: (details) {
              setState(() {
                _width += details.delta.dx;

                // prevent overflow if height is more/less than available space
                var maxLimit = _maxWidth - _dividerHeight - _dividerSpace;
                var minLimit = 44.0;

                if (_width > maxLimit)
                  _width = maxLimit;
                else if (_width < minLimit) _width = minLimit;
              });
            },
          )
        ],
      ),
    );
  }
}
