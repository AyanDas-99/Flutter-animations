// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
