import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';

import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    required this.pin1,
    required this.pin2,
    required this.pin3,
    required this.pin4,
    super.key,
  });

  final String? pin1;
  final String? pin2;
  final String? pin3;
  final String? pin4;
  @override
  State<VerifyScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<VerifyScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();

  String? setpin1;
  String? setpin2;
  String? setpin3;
  String? setpin4;

  String wrongpin = '';

  @override
  void dispose() {
    code1controller.text;
    code2controller.text;
    code3controller.text;
    code4controller.text;
    super.dispose();
  }

  final _code1FocusNode = FocusNode();
  final _code2FocusNode = FocusNode();
  final _code3FocusNode = FocusNode();
  final _code4FocusNode = FocusNode();

  Future<void> securitypin() async {
    if (code1controller.text == widget.pin1 &&
        code2controller.text == widget.pin2 &&
        code3controller.text == widget.pin3 &&
        code4controller.text == widget.pin4) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const LoginScreen();
      }));
      var userDatas = json.encode({
        'controller1': code1controller.text,
        'controller2': code2controller.text,
        'controller3': code3controller.text,
        'controller4': code4controller.text,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', userDatas);
      onVerify();

      // print('Hello');
    } else {
      setState(() {
        wrongpin = 'PIN did not match!';
      });
    }
  }
  //onverifyprovidercode
  Future<void> onVerify() async {
    final prefs = await SharedPreferences.getInstance();

    var extracteduserdata = json.decode(prefs.getString('userData')!);

    setState(() {
      Provider.of<TapitProvider>(context, listen: false).setpin1 =
          extracteduserdata['controller1'];
      Provider.of<TapitProvider>(context, listen: false).setpin2 =
          extracteduserdata['controller2'];
      Provider.of<TapitProvider>(context, listen: false).setpin3 =
          extracteduserdata['controller3'];
      Provider.of<TapitProvider>(context, listen: false).setpin4 =
          extracteduserdata['controller4'];
    });

    print(extracteduserdata);
  }

//calculator logic
  void calculatorfunction(String btnvalue) {
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
          calculatorfunction(btntxt);
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
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 85, right: 85),
                      child: Image.asset(
                        'assets/verifylogo.png',
                        width: double.infinity,
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: screenwidth - 140,
                    child: Text(
                      'Kindly re-enter your 4-Digit Pin.',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  //reusablecodetextfield
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
                            obscuremode: false,
                          ),
                          VerificationWidget(
                           onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                            keyboardnone: TextInputType.none,
                            controller1: code2controller,
                            obscuremode: false,
                          ),
                          VerificationWidget(
                           onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                            keyboardnone: TextInputType.none,
                            controller1: code3controller,
                            obscuremode: false,
                          ),
                          VerificationWidget(
                            onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context);
                                }
                              },
                            keyboardnone: TextInputType.none,
                            controller1: code4controller,
                            obscuremode: false,
                          ),
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      wrongpin,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffF74242),
                      ),
                    ),
                  ),
                ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buttons('1'),
                                buttons('2'),
                                buttons('3'),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buttons('4'),
                                buttons('5'),
                                buttons('6'),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buttons('7'),
                                buttons('8'),
                                buttons('9'),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(left: 79, right: 30),
                            child: Row(children: [
                              buttons('0'),
                              //cancelbutton
                              InkWell(
                                onTap: () {
                                  if (code4controller.text.isNotEmpty) {
                                    setState(() {
                                      code4controller.text = '';
                                    });
                                  } else if (code3controller.text.isNotEmpty) {
                                    setState(() {
                                      code3controller.text = '';
                                    });
                                  } else if (code2controller.text.isNotEmpty) {
                                    setState(() {
                                      code2controller.text = '';
                                    });
                                  } else if (code1controller.text.isNotEmpty) {
                                    setState(() {
                                      code1controller.text = '';
                                    });
                                  }
                                },
                                child: Image.asset('assets/cleared.png'),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        securitypin();
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          width: double.infinity,
                          child:
                              const NavigateWidget(navigationvalue: 'Verify')),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
