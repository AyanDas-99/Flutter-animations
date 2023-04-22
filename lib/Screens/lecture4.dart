// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Person {
  final String name;
  final String age;
  final String emoji;
  Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

final people = [
  Person(name: "Ayan", age: '20', emoji: '👨'),
  Person(name: "Daddu", age: '20', emoji: '👴'),
  Person(name: "Thakur ji", age: '20', emoji: '👮'),
  Person(name: "Angela", age: '20', emoji: '👼'),
];

class Lecture4 extends StatefulWidget {
  final String title;
  const Lecture4({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture4> createState() => _Lecture4State();
}

class _Lecture4State extends State<Lecture4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          Person person = people[index];
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(person: people[index]),
                )),
            child: ListTile(
              leading: Hero(
                tag: person.name,
                child: Text(
                  person.emoji,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text(person.name),
              subtitle: Text("${person.age} years old"),
            ),
          );
        },
      ),
    );
  }
}

class Details extends StatelessWidget {
  final Person person;

  const Details({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                    color: Colors.transparent, child: fromHeroContext.widget);
                break;
              case HeroFlightDirection.pop:
                return Material(
                    color: Colors.transparent, child: toHeroContext.widget);
                break;
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(person.name),
          SizedBox(
            height: 20,
          ),
          Text("${person.age} years old")
        ],
      )),
    );
  }
}
