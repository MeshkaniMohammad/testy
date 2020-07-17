import 'package:flutter/material.dart';


class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    Key key,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static MyInheritedWidget of(BuildContext context) {
    // ignore: deprecated_member_use
    return context.inheritFromWidgetOfExactType(MyInheritedWidget) as MyInheritedWidget;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget old) {
    return ;
  }
}