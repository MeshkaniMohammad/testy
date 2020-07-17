import 'package:flutter/material.dart';

class AutoScroll extends StatefulWidget {
  @override
  _AutoScrollState createState() => _AutoScrollState();
}

class _AutoScrollState extends State<AutoScroll> {
  final focus = FocusNode();
  final double _itemExtent = 100.0;
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("auto scroll"),),
      body: ListView(
        itemExtent: _itemExtent,
        controller: _controller,
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            autofocus: true,
            onFieldSubmitted: (v){
              FocusScope.of(context).requestFocus(focus);
              _controller.jumpTo(_itemExtent + 200.0);
              print(v);
            },
          ),
          TextFormField(
            focusNode: focus,
            decoration: InputDecoration(labelText: "Input 2"),
          ),
        ],
      ),
    );
  }
}
