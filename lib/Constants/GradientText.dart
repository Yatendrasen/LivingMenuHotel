import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final double fontSize;
  final String fontFamily;
  final double height;
  // final String fontWeight;

  GradientText(this.text, {required this.gradient, required this.fontSize,
    required this.fontFamily, required this.height});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            height: height
        ),
      ),
    );
  }
}