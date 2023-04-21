// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Lecture1 extends StatefulWidget {
  final String title;
  const Lecture1({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture1> createState() => _Lecture1State();
}

class _Lecture1State extends State<Lecture1> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animation =
        Tween<double>(begin: 0.0, end: math.pi * 2).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(_animation.value)
                ..rotateZ(_animation.value)
                ..rotateX(_animation.value),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.lightBlueAccent,
                          Color.fromARGB(255, 19, 98, 163)
                        ]),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 151, 201, 246),
                          blurRadius: 20,
                          spreadRadius: 1),
                    ],
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
        ),
      ),
    );
  }
}
