// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Lecture3 extends StatefulWidget {
  final String title;
  const Lecture3({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture3> createState() => _Lecture3State();
}

class _Lecture3State extends State<Lecture3> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    _yController =
        AnimationController(vsync: this, duration: Duration(seconds: 15));

    _zController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: AnimatedBuilder(
          animation:
              Listenable.merge([_xController, _yController, _zController]),
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(_animation.evaluate(CurvedAnimation(
                  parent: _xController, curve: Curves.bounceInOut)))
              ..rotateY(_animation.evaluate(CurvedAnimation(
                  parent: _yController, curve: Curves.bounceOut)))
              ..rotateZ(_animation.evaluate(CurvedAnimation(
                  parent: _zController, curve: Curves.bounceOut))),
            child: Stack(
              children: [
                // Back
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..translate(Vector3(0, 0, -100)),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Color.fromARGB(255, 93, 171, 236),
                  ),
                ),

                // Left Side
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Color.fromARGB(255, 98, 176, 240),
                    )),

                // Right Side
                Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Color.fromARGB(255, 77, 144, 199),
                    )),

                // Top Side
                Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Color.fromARGB(255, 111, 190, 255),
                    )),

                // Top Side
                Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Color.fromARGB(255, 52, 157, 243),
                    )),

                // Front
                Container(
                  height: 100,
                  width: 100,
                  color: Color.fromARGB(255, 114, 185, 247),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
