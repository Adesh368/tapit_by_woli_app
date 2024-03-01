import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/screens/verify_pin_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String? setpin1;
  String? setpin2;
  String? setpin3;
  String? setpin4;
  @override
  void dispose() {
    code1controller.text;
    code2controller.text;
    code3controller.text;
    code4controller.text;
    super.dispose();
  }

  Future<void> securitypin() async {
    var userDatas = json.encode({
      'controller1': code1controller.text,
      'controller2': code2controller.text,
      'controller3': code3controller.text,
      'controller4': code4controller.text,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usercode', userDatas);
    

    // print('Hello');
  }

  

  final _code1FocusNode = FocusNode();
  final _code2FocusNode = FocusNode();
  final _code3FocusNode = FocusNode();
  final _code4FocusNode = FocusNode();
//calculator logic
  void valuefunction(String btnvalue) {
    if (code1controller.text.isEmpty) {
      setState(() {
        code1controller.text = btnvalue;
      });
    } else if (code1controller.text.isNotEmpty &&
        code2controller.text.isEmpty) {
      //FocusScope.of(context).nextFocus();
      setState(() {
        code2controller.text = btnvalue;
      });
    } else if (code2controller.text.isNotEmpty &&
        code3controller.text.isEmpty) {
      //FocusScope.of(context).nextFocus();
      setState(() {
        code3controller.text = btnvalue;
      });
    } else if (code3controller.text.isNotEmpty &&
        code4controller.text.isEmpty) {
      //FocusScope.of(context).nextFocus();
      setState(() {
        code4controller.text = btnvalue;
      });
    }
  }

  // calculator widegt
  Widget buttons(String btntxt) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          valuefunction(btntxt);
        },
        child: Text(
          btntxt,
          style: GoogleFonts.mulish(
            fontSize: 31.72,
            fontWeight: FontWeight.w600,
            color: const Color(0xff001533),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(children: [
            Expanded(
              child: Container(
                //height: screenheight-500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 85, right: 85),
                        child: Image.asset(
                          'assets/setpin.png',
                          width: double.infinity,
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: screenwidth - 140,
                      child: Text(
                        'Choose a 4-Digit Pin to login and complete transactions.',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff666666),
                        ),
                      ),
                    ),
                    Container(
                      width: screenwidth - 150,
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VerificationWidget(
                             onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code1controller,
                              obscuremode: true,
                            ),
                            VerificationWidget(
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code2controller,
                              obscuremode: true,
                            ),
                            VerificationWidget(
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code3controller,
                              obscuremode: true,
                            ),
                            VerificationWidget(
                             onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code4controller,
                              obscuremode: true,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              //height: screenheight - 500,
              width: screenwidth,
              padding: EdgeInsets.only(
                  top: 10, left: 30, right: 30, bottom: screenheight - 773),
              decoration: const BoxDecoration(
                color: Color(0xffF2F3FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //buttonvalue
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10),
                      width: screenwidth,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buttons('1'),
                                  buttons('2'),
                                  buttons('3'),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buttons('4'),
                                  buttons('5'),
                                  buttons('6'),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buttons('7'),
                                  buttons('8'),
                                  buttons('9'),
                                ]),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 79, right: 30),
                              child: Row(children: [
                                buttons('0'),
                                //cancelbutton
                                InkWell(
                                  onTap: () {
                                    if (code4controller.text.isNotEmpty) {
                                      setState(() {
                                        code4controller.text = '';
                                      });
                                    } else if (code3controller
                                        .text.isNotEmpty) {
                                      setState(() {
                                        code3controller.text = '';
                                      });
                                    } else if (code2controller
                                        .text.isNotEmpty) {
                                      setState(() {
                                        code2controller.text = '';
                                      });
                                    } else if (code1controller
                                        .text.isNotEmpty) {
                                      setState(() {
                                        code1controller.text = '';
                                      });
                                    }
                                  },
                                  child: Image.asset('assets/cleared.png'),
                                ),
                              ]),
                            )
                          ]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (
                          ctx,
                        ) {
                          return const Snavigate();
                        }));
                        securitypin();
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          width: double.infinity,
                          child:
                              const NavigateWidget(navigationvalue: 'Set PIN')),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
