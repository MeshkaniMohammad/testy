import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: MyApp(),),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hove icons"),),
      body: Column(
        children: [
          SizedBox(height: 200,),

        ],
      ),
    );
  }
}
