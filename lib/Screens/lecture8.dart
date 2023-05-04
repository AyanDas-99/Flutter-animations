import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Lecture8 extends StatefulWidget {
  final String title;
  const Lecture8({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture8> createState() => _Lecture8State();
}

class _Lecture8State extends State<Lecture8> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _yRotationAnimationForChild;

  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    _xControllerForChild =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForChild =
        Tween<double>(begin: 0, end: -pi / 2).animate(_xControllerForChild);

    _xControllerForDrawer =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForDrawer =
        Tween<double>(begin: pi / 2.7, end: 0).animate(_xControllerForDrawer);

    super.initState();
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: AnimatedBuilder(
        animation:
            Listenable.merge([_xControllerForChild, _xControllerForDrawer]),
        builder: (context, child) => GestureDetector(
          onHorizontalDragUpdate: (details) {
            final delta = details.delta.dx / maxDrag;
            _xControllerForChild.value += delta;
            _xControllerForDrawer.value += delta;
          },
          onHorizontalDragEnd: (details) {
            if (_xControllerForChild.value < 0.5) {
              _xControllerForChild.reverse();
              _xControllerForDrawer.reverse();
            } else {
              _xControllerForChild.forward();
              _xControllerForDrawer.forward();
            }
          },
          child: Stack(
            children: [
              Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xControllerForChild.value * maxDrag)
                    ..rotateY(_yRotationAnimationForChild.value),
                  child: const Home()),
              Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                        -screenWidth + _xControllerForDrawer.value * maxDrag)
                    ..rotateY(_yRotationAnimationForDrawer.value),
                  child: const MyDrawer()),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color.fromARGB(255, 49, 65, 73),
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 80, top: 100),
          itemCount: 20,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
          ),
        ),
      ),
    );
  }
}
