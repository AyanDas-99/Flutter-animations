// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Lecture2 extends StatefulWidget {
  final String title;
  const Lecture2({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture2> createState() => _Lecture2State();
}

class _Lecture2State extends State<Lecture2> with TickerProviderStateMixin {
  late AnimationController _counterClockRotationController;
  late Animation _counterClockAnimation;

  late AnimationController _flipController;
  late Animation _flipAnimation;

  @override
  void initState() {
    _counterClockRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockAnimation = Tween<double>(begin: 0, end: -math.pi / 2).animate(
        CurvedAnimation(
            parent: _counterClockRotationController, curve: Curves.bounceOut));

    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flipAnimation = Tween<double>(begin: 0, end: math.pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _counterClockRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("rotation completed");
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value,
                end: _flipAnimation.value + math.pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("flip completed");
        _counterClockAnimation = Tween<double>(
                begin: _counterClockAnimation.value,
                end: _counterClockAnimation.value - math.pi / 2)
            .animate(CurvedAnimation(
                parent: _counterClockRotationController,
                curve: Curves.bounceOut));
        _counterClockRotationController
          ..reset()
          ..forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _counterClockRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _counterClockRotationController.forward();
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: _counterClockRotationController,
            builder: (context, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_counterClockAnimation.value),
              child: AnimatedBuilder(
                animation: _flipController,
                builder: (context, child) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                          clipper: SemiCircleClipper(side: CircleSide.left),
                          child: Container(
                              height: 150, width: 150, color: Colors.blue)),
                      ClipPath(
                          clipper: SemiCircleClipper(side: CircleSide.right),
                          child: Container(
                              height: 150, width: 150, color: Colors.yellow)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

enum CircleSide { left, right }

class SemiCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  SemiCircleClipper({
    required this.side,
  });

  @override
  getClip(Size size) {
    final Path path = Path();

    if (side == CircleSide.left) {
      path.moveTo(size.width, 0);
      path.arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(size.width / 2), clockwise: false);
      path.close();
    } else {
      path.arcToPoint(Offset(0, size.height),
          radius: Radius.circular(size.width / 2), clockwise: true);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
