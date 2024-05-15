import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({required this.data, required this.title,super.key});
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            title,
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            data,
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1F1F1F),
            ),
          ),
        ]),
      ),
    );
  }
}
