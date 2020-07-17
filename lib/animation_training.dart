import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimationTraining extends StatefulWidget {
  @override
  _AnimationTrainingState createState() => _AnimationTrainingState();
}

class _AnimationTrainingState extends State<AnimationTraining> {
  Animation _animation;
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(parent: null, curve: null);
    _animationController.fling(animationBehavior: AnimationBehavior.normal,velocity: 1.0);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
