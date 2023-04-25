// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Practice1 extends StatefulWidget {
  const Practice1({super.key});

  @override
  State<Practice1> createState() => _Practice1State();
}

class _Practice1State extends State<Practice1> with TickerProviderStateMixin {
  late AnimationController _birdController;
  late Animation _birdAnimation;

  late AnimationController _wave1Controller;
  late AnimationController _wave2Controller;
  late AnimationController _wave3Controller;

  late Animation _wave1Animation;
  late Animation _wave2Animation;
  late Animation _wave3Animation;

  @override
  void initState() {
    // Animation Controllers
    _wave1Controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _wave2Controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _wave3Controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    // Animations
    _wave1Animation =
        Tween<double>(begin: 70, end: 90).animate(_wave1Controller);
    _wave2Animation =
        Tween<double>(begin: 0, end: 10).animate(_wave2Controller);
    _wave3Animation =
        Tween<double>(begin: 0, end: 10).animate(_wave3Controller);

    // Listeners
    _wave1Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _wave1Controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _wave1Controller.forward();
      }
    });

    _wave2Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _wave2Controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _wave2Controller.forward();
      }
    });

    _wave3Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _wave3Controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _wave3Controller.forward();
      }
    });

    _birdController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _birdAnimation = Tween<double>(begin: 0, end: 10).animate(_birdController);

    _birdController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _birdController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _birdController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _birdController.dispose();
    _wave1Controller.dispose();
    _wave2Controller.dispose();
    _wave3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _birdController.forward();
    _wave3Controller.forward();
    _wave2Controller.forward();
    _wave1Controller.forward();
    return TweenAnimationBuilder(
      tween: ColorTween(begin: Colors.black, end: Colors.transparent),
      duration: const Duration(seconds: 6),
      builder: (context, value, child) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.yellowAccent,
          Colors.orangeAccent,
          Colors.orange
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Scaffold(
          backgroundColor: value,
          appBar: AppBar(
            title: const Text("Sunrise"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 115,
                  ),
                  AnimatedBuilder(
                    animation: _birdController,
                    builder: (context, child) => Transform.translate(
                        offset: Offset(0, -_birdAnimation.value),
                        child: const Bird()),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  AnimatedBuilder(
                    animation: _birdController,
                    builder: (context, child) => Transform.translate(
                        offset: Offset(0, -_birdAnimation.value),
                        child: const Bird()),
                  ),
                ],
              ),
              const Bird(),
              Expanded(child: Container()),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 70),
                      duration: const Duration(seconds: 6),
                      builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, -value), child: const Sun())),
                  AnimatedBuilder(
                    animation: _wave3Controller,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, -_wave3Animation.value),
                      child: ClipPath(
                          clipper: WaveClipper(waves: 4),
                          child: Container(
                            width: 400,
                            height: 150,
                            color: Colors.blue[100],
                          )),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _wave2Controller,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, -_wave2Animation.value),
                      child: ClipPath(
                        clipper: WaveClipper(waves: 5),
                        child: Container(
                          width: 400,
                          height: 120,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _wave1Controller,
                    builder: (context, child) => ClipPath(
                      clipper: WaveClipper(waves: 6),
                      child: Container(
                        width: 400,
                        height: _wave1Animation.value,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BirdClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.arcToPoint(Offset(size.width / 2, size.height / 2),
        radius: Radius.circular(size.height / 4));
    path.arcToPoint(Offset(size.width, size.height / 2),
        radius: Radius.circular(size.height / 4));
    path.arcToPoint(Offset(size.width / 2, size.height),
        clockwise: false, radius: Radius.circular(size.height / 6));
    path.arcToPoint(Offset(0, size.height / 2),
        clockwise: false, radius: Radius.circular(size.height / 6));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class WaveClipper extends CustomClipper<Path> {
  final int waves;
  WaveClipper({
    required this.waves,
  });

  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 5);
    for (int i = 1; i < waves + 1; i++) {
      path.arcToPoint(Offset(i * size.width / waves, size.height / waves),
          radius: Radius.circular(size.height));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BirdClipper(),
      child: Container(height: 20, width: 40, color: Colors.black),
    );
  }
}

class Sun extends StatelessWidget {
  const Sun({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 2)),
      ),
    );
  }
}
