import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff111317),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Color(0xff111317),
          ),
        ),
        actions: <Widget>[
          Image.asset(
            'assets/edit.png',
            color: Color(0xff111317),
          ),
          Image.asset(
            'assets/settings.png',
            color: Color(0xff111317),
            height: 30,
            width: 30,
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        sized: false,
        value: const SystemUiOverlayStyle(statusBarColor: Colors.white),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
