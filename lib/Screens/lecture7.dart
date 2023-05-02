import 'package:flutter/material.dart';
import 'dart:math' show cos, pi, sin;

class Lecture7 extends StatefulWidget {
  final String title;
  const Lecture7({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture7> createState() => _Lecture7State();
}

class Polygon extends CustomPainter {
  final int sides;
  Polygon({
    required this.sides,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);

    final angle = 2 * pi / sides;

    final angles = List.generate(sides, (index) => index * angle);

    final radius = size.width / 2;

    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));

    for (final angle in angles) {
      path.lineTo(
          center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class _Lecture7State extends State<Lecture7> with TickerProviderStateMixin {
  // Animations
  late AnimationController sidesController;
  late Animation<int> sidesAnimation;
  late AnimationController radiusController;
  late Animation radiusAnimation;
  late AnimationController rotationController;
  late Animation rotationAnimation;

  @override
  void initState() {
    sidesController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    sidesAnimation = IntTween(begin: 3, end: 10).animate(sidesController);

    radiusController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    radiusAnimation = Tween<double>(begin: 10, end: 400).animate(
        CurvedAnimation(parent: radiusController, curve: Curves.bounceInOut));

    rotationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(rotationController);

    super.initState();
  }

  @override
  void dispose() {
    sidesController.dispose();
    radiusController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sidesController.repeat(reverse: true);
    radiusController.repeat(reverse: true);
    rotationController.repeat(reverse: true);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [sidesController, radiusController, rotationController]),
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(rotationAnimation.value)
              ..rotateY(rotationAnimation.value)
              ..rotateZ(rotationAnimation.value),
            child: CustomPaint(
              painter: Polygon(sides: sidesAnimation.value),
              child: SizedBox(
                width: radiusAnimation.value,
                height: radiusAnimation.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
