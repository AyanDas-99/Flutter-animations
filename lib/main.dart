import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const MyHomePage(title: 'AnimatedSwitcher'),
        
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
  final allAssets = [
    'assets/1677751434999.jpeg',
    'assets/1681746373201.jpeg',
    'assets/1677749490747.jpeg',
    'assets/11.jpg'
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (child, Animation<double> animation) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Container(
              key: UniqueKey(),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(allAssets[current]))),
            ),
          ),
          IconButton(
              onPressed: () {
                if (current == 3) return null;
                setState(() {
                  current++;
                });
              },
              icon: Icon(Icons.forward)),
          IconButton(
              onPressed: () {
                if (current == 0) return null;
                setState(() {
                  current--;
                });
              },
              icon: Icon(Icons.arrow_back)),
        ],
      ),
    );
  }
}
