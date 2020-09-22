import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyHomePage(title: 'title',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  Command<void, String> _incrementCounterCommand;

  _MyHomePageState() {
    _incrementCounterCommand = Command.createSyncNoParam(() {
      counter++;
      return counter.toString();
    }, '0');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ValueListenableBuilder<String>(
              valueListenable: _incrementCounterCommand,
              builder: (context, val, _) {
                return Text(
                  val,
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounterCommand,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}