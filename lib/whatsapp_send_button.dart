import 'package:flutter/material.dart';
void main() => runApp(TestApp());
class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandbox for Testing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: CustomButton(),
      ),
    );
  }
}
class CustomButton extends StatefulWidget {
  const CustomButton({Key key}) : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}
class _CustomButtonState extends State<CustomButton> {
  Widget _child;
  final Icon _micIcon = const Icon(Icons.mic, key: Key('mic'), color: Colors.white);
  final Icon _arrow = const Icon(Icons.send, key: Key('arrow'), color: Colors.white);
  @override
  void initState() {
    super.initState();
    _child = _micIcon;
  }
  void _changeTheButton() {
    setState(() {
      _child == _micIcon ? _child = _arrow : _child = _micIcon;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (f) => _changeTheButton(),
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 150,
          ),
          child: _child,
        ),
      ),
    );
  }
}