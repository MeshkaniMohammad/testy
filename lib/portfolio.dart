import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testy/strings/strings.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondPortfolio(),
    ),
  );
}

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  Widget body = AboutMe();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 2.3,
          title: Header(
            height: MediaQuery.of(context).size.height / 3,
          ),
          centerTitle: true,
          bottom: TabBar(
            onTap: (int index) {
              switch (index) {
                case 0:
                  setState(() {
                    body = AboutMe();
                  });
                  break;
                case 1:
                  setState(() {
                    body = Skills();
                  });
                  break;
                case 2:
                  setState(() {
                    body = Projects();
                  });
                  break;
                case 3:
                  setState(() {
                    body = ContactMe();
                  });
                  break;
                default:
                  setState(() {
                    body = AboutMe();
                  });
              }
            },
            tabs: [
              Tab(
                text: "About Me",
              ),
              Tab(text: "Skills"),
              Tab(
                text: "Projects",
              ),
              Tab(
                text: "Contact me",
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: body,
        ),
      ),
    ));
  }
}

class Header extends StatelessWidget {
  final double height;

  const Header({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(radius: 80, backgroundImage: AssetImage('assets/profile.jpeg')),
          Text("Mohammad Meshkani"),
          Text("Flutter Developer"),
        ],
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(Strings.aboutMe),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('skills'),
      ),
    );
  }
}

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('[projects'),
      ),
    );
  }
}

class ContactMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('contact me'),
    );
  }
}

class SecondPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              child: Container(
                color: Colors.black,
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
              flex: 1,
            ),
          ],
        ),
        Align(
          child: MyCard(),
        ),
      ],
    );
  }
}

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with TickerProviderStateMixin {
  AnimationController slideAnimationForBottomController;
  Animation<Offset> slideAnimationForBottom;
  AnimationController _opacityAnimationForBottomController;
  Animation _opacityAnimationForBottom;
  AnimationController slideAnimationForTopController;
  Animation<Offset> slideAnimationForTop;
  AnimationController _opacityAnimationForTopController;
  Animation _opacityAnimationForTop;
  bool _logoOpacity = true;
  AnimationController _slideImageAnimationController;
  Animation<Offset> _slideImageAnimation;
  @override
  void initState() {
    super.initState();

    slideAnimationForBottomController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _slideImageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityAnimationForBottomController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityAnimationForBottom =
        Tween<double>(begin: 0.5, end: 1.0).animate(_opacityAnimationForBottomController);
    slideAnimationForBottom = Tween<Offset>(begin: Offset(0.0, 0.35), end: Offset.zero)
        .animate(slideAnimationForBottomController);
    slideAnimationForTopController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityAnimationForTopController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityAnimationForTop =
        Tween<double>(begin: 0.5, end: 1.0).animate(_opacityAnimationForTopController);
    slideAnimationForTop = Tween<Offset>(begin: Offset(0.0, -0.5), end: Offset(0.0, 0.05))
        .animate(slideAnimationForTopController);
    _slideImageAnimation = Tween<Offset>(begin: Offset(-0.6, 0.0), end: Offset(2.5, 0.0))
      .animate(_slideImageAnimationController);
    Future.delayed(Duration(seconds: 2),(){
      _opacityAnimationForTopController.forward();
      slideAnimationForTopController.forward();
      _opacityAnimationForBottomController.forward();
      slideAnimationForBottomController.forward();
    });

    Future.delayed(Duration(seconds: 4),(){
      setState(() {
        _logoOpacity = false;
      });
      _slideImageAnimationController.forward();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 200,
        child: Stack(
          children: [
            Align(
              child: Opacity(opacity: _logoOpacity ? 1.0 : 0.0 ,child: FlareActor(
                'assets/finish_logo.flr',
                animation: 'finish',
              ),),
            ),
            Align(
              child: SlideTransition(
                position: slideAnimationForTop,
                child: FadeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png',width: 40,height: 30,),
                  ),
                  opacity: _opacityAnimationForTop,
                ),
              ),
              alignment: Alignment.topLeft,
            ),
            Align(
              child: SlideTransition(
                position: slideAnimationForTop,
                child: FadeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CONTACT",
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ),
                  opacity: _opacityAnimationForTop,
                ),
              ),
              alignment: Alignment.topRight,
            ),
            Align(
              child: SlideTransition(
                position: slideAnimationForBottom,
                child: FadeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.down_arrow,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  opacity: _opacityAnimationForBottom,
                ),
              ),
              alignment: Alignment.bottomRight,
            ),
            Align(
              child: SlideTransition(
                position: slideAnimationForBottom,
                child: FadeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.github),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedin),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  opacity: _opacityAnimationForBottom,
                ),
              ),
              alignment: Alignment.bottomLeft,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SlideTransition(position: _slideImageAnimation,child: Image.asset('assets/m.png'),),)
          ],
        ),
      ),
    );
  }
}
