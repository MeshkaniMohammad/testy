import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySwancy(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List<Widget> cardList;
  CardController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  //Use this to trigger swap.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
            orientation: AmassOrientation.TOP,
            totalNum: 3,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => FlipCard(
              key: Key('flip$index'),
              direction: FlipDirection.HORIZONTAL,
              speed: 1000,
              onFlipDone: (status) {
                print(status);
              },
              front: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF006666),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Front', style: Theme.of(context).textTheme.headline),
                    Text('Click here to flip back', style: Theme.of(context).textTheme.body1),
                  ],
                ),
              ),
              back: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF006666),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Back', style: Theme.of(context).textTheme.headline),
                    Text('Click here to flip front', style: Theme.of(context).textTheme.body1),
                  ],
                ),
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          ),
        ),
      ),
    );
  }
}

class MySwancy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("trying"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  child: myCard(),
                ),
                Positioned(
                  left: 30,
                  child: myCard(),
                ),
                Positioned(
                  left: 20,
                  child: myCard(),
                ),
                Positioned(
                  left: 10,
                  child: myCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card myCard() {
    return Card(
      child: Container(
        width: 200,
        height: 400,
        child: Center(
          child: Text("xxxx"),
        ),
      ),
    );
  }
}
