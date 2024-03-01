import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';

class VerificationWidget extends StatelessWidget {
  VerificationWidget({
    this.obscuremode = true,
    this.isLast = false,
    this.onSubmitted,
    required this.onChanged,
    
    required this.controller1,
    this.readonly = true,
    required this.keyboardnone,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller1;
  final TextInputType keyboardnone;

  final ValueChanged<String>? onSubmitted;
  final bool isLast;
  final bool readonly;
  
  final ValueChanged<String> onChanged;

  bool obscuremode;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Container(
      //height: 45,
      width: screenwidth - 350,
      //padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffE6E9FF),
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        readOnly: readonly,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        // focusNode: focusNodes,
        controller: controller1,
        obscureText: obscuremode,
        textAlign: TextAlign.center,
        keyboardType: keyboardnone,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: GoogleFonts.mulish(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1F1F1F),
          ),
        ),
      ),
    );
  }
}
