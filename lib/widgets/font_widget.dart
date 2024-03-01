import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFontWidget extends StatelessWidget {
  const TextFontWidget(
      {required this.text,
      required this.sizes,
      this.weights = FontWeight.normal,
      required this.color,
      super.key});

  final String text;
  final FontWeight weights;
  final double sizes;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        color: color,
        fontSize: sizes,
        fontWeight: weights,
      ),
    );
  }
}
