import 'package:flutter/material.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
 
  
  final _formKey = GlobalKey<FormState>();
  List<Map<String,int>> points = [
  {"Ali": 12 },
  {"hashem" : 1 },
  {"Yalda" : 22 },
  {"Mohammad": 2 },
  {"Hossein" : 65 }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ScoreBoard"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(),
                TextFormField(),
                RaisedButton(onPressed: (){},)
              ],
            ),
          ),
          Expanded(child: ListView.builder(
            itemCount: points.length,
        itemBuilder: (BuildContext context,int index){
          var sortedPoints = points[index].values;
          return ListTile(
           title: Text(points[index].keys.toList().toString()),
           trailing: Text(sortedPoints.toString()),
          );
        },
      ),)
        ],
      ),
    );
  }
}