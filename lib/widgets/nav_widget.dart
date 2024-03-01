import 'package:flutter/material.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';

class NavigateWidget extends StatelessWidget {
  const NavigateWidget({required this.navigationvalue, super.key});
  final String navigationvalue;

  @override
  Widget build(BuildContext context) {
    //final screenwidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff1E33F4),
          border: Border.all(
            width: 1,
            color: const Color(0xffF5F5FF),
          ),
        ),
        child: Center(
          child: TextFontWidget(
            text: navigationvalue,
            sizes: 21,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
    );
  }
}
