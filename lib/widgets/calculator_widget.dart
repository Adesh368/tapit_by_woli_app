import 'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget(
      {required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5,
      required this.text6,
      required this.text7,
      required this.text8,
      required this.text9,
      this.fingimage,
      required this.text0,
      required this.image,
      required this.buttonvalue,
      super.key,
      required this.buttonvalue2,
      required this.buttonvalue3,
      required this.buttonvalue4,
      required this.buttonvalue5,
      required this.buttonvalue6,
      required this.buttonvalue7,
      required this.buttonvalue8,
      required this.buttonvalue9,
      required this.buttonvalue0,
      required this.buttonvaluefingimage,
      required this.buttonvalueimgate});
  final Text text1;
  final Text text2;
  final Text text3;
  final Text text4;
  final Text text5;
  final Text text6;
  final Text text7;
  final Text text8;
  final Text text9;
  final Image? fingimage;
  final Text text0;
  final Image image;
  final Function() buttonvalue;
  final Function() buttonvalue2;
  final Function() buttonvalue3;
  final Function() buttonvalue4;
  final Function() buttonvalue5;
  final Function() buttonvalue6;
  final Function() buttonvalue7;
  final Function() buttonvalue8;
  final Function() buttonvalue9;
  final Function() buttonvalue0;
  final Function() buttonvaluefingimage;
  final Function() buttonvalueimgate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 271,
      width: 255,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 32.14,
            width: 245.4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: buttonvalue, child: text1),
                  InkWell(onTap: buttonvalue2, child: text2),
                  InkWell(onTap: buttonvalue3, child: text3),
                ]),
          ),
          SizedBox(
            height: 32.14,
            width: 245.4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: buttonvalue4, child: text4),
                  InkWell(onTap: buttonvalue5, child: text5),
                  InkWell(onTap: buttonvalue6, child: text6),
                ]),
          ),
          SizedBox(
            height: 32.14,
            width: 245.4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: buttonvalue7, child: text7),
                  InkWell(onTap: buttonvalue8, child: text8),
                  InkWell(onTap: buttonvalue9, child: text9),
                ]),
          ),
          SizedBox(
            height: 32.14,
            width: 245.4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                
                children: [
                  if (fingimage != null)
                    InkWell(onTap: buttonvaluefingimage, child: fingimage!),
                   
                  InkWell(onTap: buttonvalue0, child: text0),
                  SizedBox(width: 80,),
                  InkWell(onTap: buttonvalueimgate, child: image),
                ]),
          )
        ],
      ),
    );
  }
}
