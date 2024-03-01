import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({required this.title,required this.color ,required this.image, super.key});

  final String title;
  final String image;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 94,
      padding: const EdgeInsets.symmetric(vertical: 25, ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: const Color(0xffE6E9FF),
        ),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          image,
          color: const Color(0xffffffff),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.mulish(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xffffffff),
          ),
        ),
      ]),
    );
  }
}
