//import 'package:flutter/material.dart';
//import 'package:testy/custom_dropdwn_menu.dart';
//import 'package:testy/hero_animation/first_screen.dart';
//import 'package:testy/photo_editor.dart';
//import 'package:testy/profile.dart';
//import 'package:testy/scoreboard.dart';
//import 'package:testy/search_bar.dart';
//import 'package:testy/webview_example.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Center(
//            child: Container(
//                child: RaisedButton(
//      child: Text("next"),
//      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoEditor())),
//    ))));
//  }
//}
//




//chat ui
//import 'package:flutter/material.dart';
//import 'package:testy/chat_ui/backend_mock.dart';
//import 'package:testy/chat_ui/home_screen.dart';
//import 'package:testy/chat_ui/providers.dart';
//
//
//
//void main() {
//  final manager = MockChatManager();
//  runApp(
//    ChatProvider(
//      manager: manager,
//      child: MaterialApp(
//        title: 'Chat App',
//        theme: ThemeData(
//          primaryColor: Colors.blue,
//          accentColor: Colors.blueAccent,
//          splashColor: Colors.blueAccent.withOpacity(0.3),
//          highlightColor: Colors.blueAccent.withOpacity(0.3),
//        ),
//        home: HomeScreen(),
//      ),
//    ),
//  );
//}
//
//
//
//
//






import 'package:flutter/material.dart';

import 'package:auto_animated/auto_animated.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Auto animated example'),
        leading: LiveIconButton(
          icon: AnimatedIcons.menu_close,
          firstTooltip: 'Menu',
          secondTooltip: 'Close',
          onPressed: () {},
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: LiveList(reverse: true,
              showItemInterval: Duration(milliseconds: 500),
              showItemDuration: Duration(seconds: 1),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: _buildAnimatedItem,
            ),
          ),
        ],
      ),
    ),
  );

  /// Wrap Ui item with animation & padding
  Widget _buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
      ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, -0.1),
          ).animate(animation),
          child: Padding(
            padding: EdgeInsets.only(right: 32),
            child: _buildCard(index.toString()),
          ),
        ),
      );

  /// UI item for showing
  Widget _buildCard(String text) => Builder(
    builder: (context) => Container(
      width: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Material(
          color: Colors.lime,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    ),
  );
}