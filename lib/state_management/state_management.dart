import 'package:flutter/material.dart';
import 'package:testy/state_management/my_inherited_widget.dart';

void main(){
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int n = 0;
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("state management test"),),
          body: Center(
            child: SecondWidget(
              text: n.toString(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
            setState(() {
              n ++;
            });
          },child: Icon(Icons.add),),
        ),
      ),
    );
  }
}

class SecondWidget extends StatelessWidget {
  final String text;

  const SecondWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
    );
  }
}
