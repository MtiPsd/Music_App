import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
//****

class AnimatedSongText extends StatelessWidget {
  const AnimatedSongText({Key? key, required this.text, required this.fontSize})
      : super(key: key);

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            textStyle: TextStyle(
              fontSize: fontSize,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              color: Colors.white30,
            ),
            speed: const Duration(milliseconds: 100),
          )
        ],
        pause: const Duration(milliseconds: 500),
        repeatForever: true,
      ),
    );
  }
}
