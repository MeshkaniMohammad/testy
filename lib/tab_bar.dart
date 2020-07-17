import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  ScrollController _scrollController;
  int _position = 0;
  double _edgePosition;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _controller.addListener(tabListener);
  }

  scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.offset > 0) {
        setState(() {
          _edgePosition = _scrollController.offset;
        });
        _controller.animateTo(1);
      } else
        _controller.animateTo(0);
    }
  }

  tabListener() {
    _scrollController.animateTo(_controller.index > 0 ? _edgePosition ?? 300 : 0,
        duration: Duration(milliseconds: 1), curve: ElasticOutCurve());
    setState(() {
      _position = _controller.index;
    });
  }

  TextStyle selectedStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.w500);
  TextStyle notSelectedStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade400)]),

            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: _position == 0
                  ? <Widget>[
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 48,
                          padding: EdgeInsets.only(left: 48),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Theme.of(context).primaryColor))),
                              child: Text(
                                'help screen',
                                style: selectedStyle,
                              ),
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: 12, right: 72),
                            child: Text(
                              'contact screen',
                              style: notSelectedStyle,
                            ),
                          ))
                    ]
                  : [
                      Container(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: 12, left: 72),
                            child: Text(
                              'help screen',
                              style: notSelectedStyle,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 48,
                          padding: EdgeInsets.only(right: 48),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Theme.of(context).primaryColor))),
                              child: Text(
                                'contact screen',
                                style: selectedStyle,
                              ),
                            ),
                          )),
                    ],
            ),
          ),
          preferredSize: Size(double.infinity, 64),
        ),
        body: TabBarView(controller: _controller, children: <Widget>[
          Center(
            child: Text(
              'help screen',
            ),
          ),
          Center(
            child: Text(
              'contact screen',
            ),
          )
        ]));
  }
}










//child: TabBar(isScrollable: true,controller: _controller,tabs: _controller.index == 0 ? [
//Container(
//alignment: Alignment.center,
//width: MediaQuery.of(context).size.width - 48,
//padding: EdgeInsets.only(left: 48),
//child: Align(
//alignment: Alignment.bottomCenter,
//child: Container(
//padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
//decoration: BoxDecoration(
//border: Border(
//bottom: BorderSide(color: Theme.of(context).primaryColor))),
//child: Text(
//'help screen',
//style: selectedStyle,
//),
//),
//)),
//Container(
//alignment: Alignment.center,
//child: Container(
//alignment: Alignment.bottomCenter,
//padding: EdgeInsets.only(bottom: 12, right: 72),
//child: Text(
//'contact screen',
//style: notSelectedStyle,
//),
//))
//]: [
//Container(
//alignment: Alignment.center,
//child: Container(
//alignment: Alignment.bottomCenter,
//padding: EdgeInsets.only(bottom: 12, left: 72),
//child: Text(
//'help screen',
//style: notSelectedStyle,
//),
//)),
//Container(
//alignment: Alignment.center,
//width: MediaQuery.of(context).size.width - 48,
//padding: EdgeInsets.only(right: 48),
//child: Align(
//alignment: Alignment.bottomCenter,
//child: Container(
//padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
//decoration: BoxDecoration(
//border: Border(
//bottom: BorderSide(color: Theme.of(context).primaryColor))),
//child: Text(
//'contact screen',
//style: selectedStyle,
//),
//),
//)),
//]),