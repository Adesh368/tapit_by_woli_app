import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubSettingsWidget extends StatelessWidget {
  const SubSettingsWidget(
      {required this.image, required this.text, this.icons, super.key});

  final String image;
  final String text;
  final Widget? icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF2F3FF),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(image),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1F1F1F),
            ),
          ),
        ]),
        icons ??
            const Icon(Icons.chevron_right, color: Color(0xff1F1F1F)),
      ]),
    );
  }
}
