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

class _Lecture1State extends State<Lecture1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: math.pi * 2).animate(_controller);
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
              child: InkWell(
                onTap: () {
                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    _controller.repeat();
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          spreadRadius: 5,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
