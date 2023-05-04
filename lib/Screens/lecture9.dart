// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Lecture9 extends StatefulWidget {
  final String title;
  const Lecture9({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Lecture9> createState() => _Lecture9State();
}

class _Lecture9State extends State<Lecture9> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: AnimatedPrompt(
            title: "Thank you for your order!",
            subtitle: 'Your order will be delivered in 2 days. Enjoy!',
            child: Icon(Icons.check)),
      ),
    );
  }
}

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const AnimatedPrompt({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _yAnimation = Tween<Offset>(
            begin: const Offset(0, 0), end: Offset(0, -0.23))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _containerScaleAnimation =
        Tween<double>(begin: 2.0, end: 0.4).animate(_controller);
    _iconScaleAnimation = Tween<double>(begin: 6, end: 8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 1),
        () => _controller
          ..reset()
          ..forward());

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 100,
              minHeight: 100,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Positioned.fill(
                  child: SlideTransition(
                position: _yAnimation,
                child: ScaleTransition(
                  scale: _containerScaleAnimation,
                  child: InkWell(
                    onTap: () => _controller.reverse(),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
