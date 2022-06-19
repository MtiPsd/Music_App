import 'package:flutter/material.dart';
//*****

class AnimatedBars extends StatefulWidget {
  const AnimatedBars({
    required this.animation1,
    required this.animation2,
    required this.animation3,
    Key? key,
  }) : super(key: key);

  final Animation<double> animation1;
  final Animation<double> animation2;
  final Animation<double> animation3;

  @override
  State<AnimatedBars> createState() => AnimatedBarsState();
}

class AnimatedBarsState extends State<AnimatedBars>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizeTransition(
            sizeFactor: widget.animation1,
            child: Container(
              width: 3,
              height: 15,
              color: const Color.fromARGB(255, 176, 136, 14),
            ),
          ),
          const SizedBox(width: 2),
          SizeTransition(
            sizeFactor: widget.animation2,
            child: Container(
              width: 3,
              height: 25,
              color: const Color.fromARGB(255, 176, 136, 14),
            ),
          ),
          const SizedBox(width: 2),
          SizeTransition(
            sizeFactor: widget.animation3,
            child: Container(
              width: 3,
              height: 10,
              color: const Color.fromARGB(255, 176, 136, 14),
            ),
          ),
        ],
      ),
    );
  }
}
