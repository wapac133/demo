import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeText extends StatelessWidget {
  final String text;

  const WelcomeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        colors: [Colors.purple, Colors.blue],
        center: Alignment.center,
        radius: 0.5,
      ).createShader(bounds),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            textStyle: const TextStyle(
              fontFamily: 'ChivoMono',
              fontSize: 50,
              color: Colors.black,
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
