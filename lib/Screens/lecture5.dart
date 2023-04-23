// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Lecture5 extends StatefulWidget {
  final String title;
  const Lecture5({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture5> createState() => _Lecture5State();
}

class _Lecture5State extends State<Lecture5> {
  bool zoomed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              zoomed = !zoomed;
            });
          },
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 400),
            height: zoomed ? 400 : 100,
            width: zoomed ? 400 : 100,
            color: zoomed ? Colors.purple : Colors.blue,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()..rotateZ(zoomed ? pi : 0),
            child: Center(
              child: Text(zoomed ? "Zoom Out" : "Zoom In"),
            ),
          ),
        ),
      ),
    );
  }
}
