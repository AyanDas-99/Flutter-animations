// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:animations/Screens/lecture2.dart';
import 'package:animations/Screens/lecture3.dart';
import 'package:flutter/material.dart';

import 'Screens/lecture1.dart';

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
