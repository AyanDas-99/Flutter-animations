// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

class Lecture6 extends StatefulWidget {
  final String title;
  const Lecture6({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture6> createState() => Lecture6State();
}

class Lecture6State extends State<Lecture6> {
  Color color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ClipPath(
          clipper: CircleClipper(),
          child: TweenAnimationBuilder(
            builder: (context, Color? color, child) => ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child!),
            duration: Duration(seconds: 1),
            onEnd: () => setState(() {
              color = getRandomColor();
            }),
            tween: ColorTween(begin: getRandomColor(), end: color),
            child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}

Color getRandomColor() =>
    Colors.primaries[math.Random().nextInt(Colors.primaries.length)];

class CircleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
