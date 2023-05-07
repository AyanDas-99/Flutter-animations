// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScrollAnimation extends StatefulWidget {
  final String title;
  const ScrollAnimation({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ScrollAnimation> createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: const Icon(Icons.menu),
          title: const Text("SLIVERAPPBAR"),
          expandedHeight: 200,
          pinned: true,
          backgroundColor: Colors.deepPurpleAccent,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/008/856/903/small/mountain-road-landscape-illustration-nature-highway-through-trees-and-meadow-cartoon-background-vector.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) => Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(10)),
                height: 300,
                width: 100,
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text("The index is $index"),
                ),
              )),
        )
      ]),
    );
  }
}
