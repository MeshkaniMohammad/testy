import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: buildButton("", "text", _onTap),
  ));
}

void _onTap() {
  print("_onTap");
}

Widget buildButton(String assetImage, String text, GestureTapCallback _onTap) {
  InkBox inkBox = InkBox(
    onTap: _onTap,
    //child: Container(width: 100,height: 100,),
    imageSrc: 'https://static.farakav.com/files/pictures/thumb/01529399.jpg',
  );

  InkChildWidget inkResponse = InkChildWidget(
      inkBox: inkBox,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          inkBox,
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              'djdsfldsfjsdlghsdlghsdlghslghsdglsglsgh',
              style: TextStyle(fontSize: 14, color: Color(0xFF313E44)),
            ),
          ),
        ],
      ),
      customBorder: CircleBorder(),
      onTap: _onTap);
  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 200, minHeight: 100),
      child: Material(
        child: inkResponse,
        color: Colors.amberAccent,
      ),
    ),
  );
}

class InkChildWidget extends InkResponse {
  final InkBox inkBox;

  InkChildWidget({
    @required this.inkBox,
    Key key,
    Widget child,
    GestureTapCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    GestureTapDownCallback onTapDown,
    GestureTapCancelCallback onTapCancel,
    ValueChanged<bool> onHighlightChanged,
    BoxShape highlightShape = BoxShape.rectangle,
    Color highlightColor,
    Color splashColor,
    InteractiveInkFeatureFactory splashFactory,
    double radius,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    bool enableFeedback = true,
    bool excludeFromSemantics = false,
  }) : super(
          containedInkWell: true,
          highlightShape: highlightShape,
          customBorder: customBorder,
          child: child,
          onTap: onTap,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onHighlightChanged: onHighlightChanged,
          radius: radius,
          borderRadius: borderRadius,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
        );

  @override
  RectCallback getRectCallback(RenderBox referenceBox) {
    return () => inkBox.rect(ancestor: referenceBox);
  }
}

class InkBox extends StatelessWidget {
  final String imageSrc;
  final GestureTapCallback onTap;
  InkBox({this.imageSrc, this.child, this.onTap});
  final Widget child;
  BuildContext context;

  Rect rect({RenderObject ancestor}) =>
      (context.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero, ancestor: ancestor) &
      context.size;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      width: 100,height: 100,
      child: FlatButton(onPressed: onTap, child: null),
      decoration: BoxDecoration(
       
        image: DecorationImage( image: NetworkImage(imageSrc))),
    );
  }
}
