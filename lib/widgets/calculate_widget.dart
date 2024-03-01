import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculateWidget extends StatefulWidget {
  const CalculateWidget(
      {required this.btntxt, required this.controllerval, super.key});
  final String btntxt;
  final String controllerval;

  @override
  State<CalculateWidget> createState() => _CalculateWidgetState();
}

class _CalculateWidgetState extends State<CalculateWidget> {
  //final void Function() btxvalue;
  String operand = '';
  void btnvalue(String textfieldtext) {
     textfieldtext = '';
     operand = widget.btntxt;
    if (textfieldtext.isEmpty) {
      
      setState(() {
        textfieldtext = widget.btntxt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          btnvalue(widget.controllerval);
        },
        child: Text(
          widget.btntxt,
          style: GoogleFonts.mulish(
            fontSize: 31.72,
            fontWeight: FontWeight.w600,
            color: Color(0xff001533),
          ),
        ),
      ),
    );
  }
}
