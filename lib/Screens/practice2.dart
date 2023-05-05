// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class Practice2 extends StatefulWidget {
  final String title;
  const Practice2({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Practice2> createState() => _Practice2State();
}

class _Practice2State extends State<Practice2>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    // ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List angles = List.generate(6, (index) => index * 360 / 6);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: RotationTransition(
        turns: Tween<double>(begin: 0, end: 0.3).animate(controller),
        child: Stack(
          children: [
            Btn(const Icon(Icons.call), 100, angles.removeAt(0), controller),
            Btn(const Icon(Icons.ac_unit_sharp), 100, angles.removeAt(0),
                controller),
            Btn(const Icon(Icons.access_time_filled_rounded), 100,
                angles.removeAt(0), controller),
            Btn(const Icon(Icons.account_balance), 100, angles.removeAt(0),
                controller),
            Btn(const Icon(Icons.add_a_photo), 100, angles.removeAt(0),
                controller),
            Btn(const Icon(Icons.adb), 100, angles.removeAt(0), controller),
            Btn(const Icon(Icons.close), 0, 0, controller),
            InkWell(
                onTap: () {
                  if (controller.isCompleted) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                child: IgnorePointer(
                    child: ScaleTransition(
                        scale:
                            Tween<double>(begin: 1, end: 0).animate(controller),
                        child: Btn(
                            const Icon(Icons.open_with), 0, 0, controller)))),
          ],
        ),
      )),
    );
  }
}

class Btn extends StatefulWidget {
  final Widget icon;
  final double radius;
  final double angle;
  final AnimationController controller;

  const Btn(this.icon, this.radius, this.angle, this.controller);

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    late Animation<Offset> animation = Tween<Offset>(
            begin: Offset(0, 0),
            end: Offset(widget.radius * cos(radians(widget.angle)),
                widget.radius * sin(radians(widget.angle))))
        .animate(CurvedAnimation(
            parent: widget.controller,
            curve: const Interval(0, 0.7, curve: Curves.easeOut)));

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => Transform.translate(
        offset: animation.value,
        child: IconButton(
          onPressed: () {},
          icon: widget.icon,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
              iconColor: MaterialStatePropertyAll(Colors.white)),
        ),
      ),
    );
  }
}
