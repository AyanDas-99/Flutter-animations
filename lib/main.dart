// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:animations/Screens/lecture2.dart';
import 'package:animations/Screens/lecture3.dart';
import 'package:animations/Screens/lecture4.dart';
import 'package:animations/Screens/lecture5.dart';
import 'package:animations/Screens/lecture6.dart';
import 'package:animations/Screens/practice1.dart';
import 'package:flutter/material.dart';

import 'Screens/lecture1.dart';
import 'Screens/lecture7.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Animations'),
        'lec1/': (context) =>
            const Lecture1(title: 'AnimateBuilder and Transform'),
        'lec2/': (context) => const Lecture2(
              title: 'Chained Animations, curves and clippers',
            ),
        'lec3/': (context) =>
            const Lecture3(title: "3D Animation, Stack and rotate widgets"),
        'lec4/': (context) => const Lecture4(title: "Hero Animation"),
        'lec5/': (context) => const Lecture5(title: "Implicit Animations"),
        'lec6/': (context) => const Lecture6(title: "TweenAnimationBuilder"),
        'practice1/': (context) => const Practice1(),
        'lec7/': (context) => const Lecture7(title: "CustomPainter & Polygons"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: [
            Link(link: "lec1/", title: "AnimatedBuilder and Transform"),
            Link(
                link: "lec2/", title: "Chained Animation, curves and clippers"),
            Link(
                link: 'lec3/',
                title: "3D Animations, Stack and rotate widgets"),
            Link(link: 'lec4/', title: 'Hero Animations'),
            Link(link: 'lec5/', title: 'Implicit Animations'),
            Link(
                link: 'lec6/',
                title: 'TweenAnimationBuilder, ClipPath, CustomClipper'),
            Link(link: 'practice1/', title: "Practice 1"),
            Link(link: 'lec7/', title: "CustomPainter & Polygons"),
          ],
        ),
      ),
    );
  }
}

class Link extends StatelessWidget {
  final String link;
  final String title;
  Link({
    Key? key,
    required this.link,
    required this.title,
  }) : super(key: key);

  final Color background =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, link),
      child: Container(
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: background.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white),
        )),
      ),
    );
  }
}
