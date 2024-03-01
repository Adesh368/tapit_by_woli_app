import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class AdvertWidget extends StatelessWidget {
  const AdvertWidget({super.key,required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
     final screenheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image:  AssetImage(image),
          height: screenheight-740,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
         Positioned(
          left: 235,
          right: 30,
          top: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('20% off Data Bundle.',
            softWrap: true,
            style: GoogleFonts.mulish(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xff1F1F1F),
              ),),
            Text('Buy Now →',style: GoogleFonts.mulish(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: const Color(0xff1E33F4),
              ),)
          ],
        ),),
      ],
    );
  }
}