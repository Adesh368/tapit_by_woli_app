import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvertWidget extends StatelessWidget {
  const AdvertWidget({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '20% off Data Bundle.',
            softWrap: true,
            style: GoogleFonts.mulish(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xff1F1F1F),
            ),
          ),
          Text(
            'Buy Now →',
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: const Color(0xff1E33F4),
            ),
          )
        ],
      ),
    );
  }
}
