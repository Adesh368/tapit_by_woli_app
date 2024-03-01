import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/model/usermodel.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    userfirstname();
    super.initState();
  }
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String wrongpin = '';
  String? pin1;
  String? pin2;
  String? pin3;
  String? pin4;
  String firstname = '';

 Future<void> userfirstname() async {
     final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('userfirstname')!);
    setState(() {
      firstname = extracteduserdata['fnamesencode'];
    });
    print('Hi');
  }
  
  //vverificationpin
  Future<void> onVerify() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('usercode')!);
    setState(() {
      pin1 = extracteduserdata['controller1'];
      pin2 = extracteduserdata['controller2'];
      pin3 = extracteduserdata['controller3'];
      pin4 = extracteduserdata['controller4'];
    });
    if (code1controller.text == pin1 &&
        code2controller.text == pin2 &&
        code3controller.text == pin3 &&
        code4controller.text == pin4) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const Snavigate();
      }));
    } else {
      setState(() {
        wrongpin = 'PIN did not match!';
      });
    }

    print(extracteduserdata);
  }

  
  //showerrordialog
  void fingerprint() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
              child: Text(
                'Authentication Required',
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1f1f1f),
                ),
              ),
            )),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/fingscanner.png'),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Place your finger on the fingerprint sensor.',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff666666),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: SizedBox(
                  // padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  child: NavigateWidget(navigationvalue: 'Use PIN')),
            ),
          ],
        ),
      ),
    );
  }
 
//calculator logic
  void calculatorfunction(String btnvalue) {
    if (code1controller.text.isEmpty) {
      setState(() {
        code1controller.text = btnvalue;
      });
    } else if (code1controller.text.isNotEmpty &&
        code2controller.text.isEmpty) {
      setState(() {
        code2controller.text = btnvalue;
      });
    } else if (code2controller.text.isNotEmpty &&
        code3controller.text.isEmpty) {
      setState(() {
        code3controller.text = btnvalue;
      });
    } else if (code3controller.text.isNotEmpty &&
        code4controller.text.isEmpty) {
      setState(() {
        code4controller.text = btnvalue;
      });
      onVerify();
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

    final automod =
        Provider.of<TapitProvider>(context, listen: false).listofname;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenwidth,
          child: Stack(children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: const AssetImage('assets/background.png'),
              height: screenheight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              top: 80,
              left: 0,
              right: 0,
              child: Column(children: [
                Expanded(
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 85, right: 85),
                        child: Image.asset(
                          'assets/taplogo.png',
                          width: double.infinity,
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: screenwidth - 140,
                      child: Text(
                        'Welcome $firstname',
                        //${automodel!.firstname}
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff666666),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Login to your account.',
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
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code1controller,
                              obscuremode: false,
                            ),
                            VerificationWidget(
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code2controller,
                              obscuremode: false,
                            ),
                            VerificationWidget(
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.none,
                              controller1: code3controller,
                              obscuremode: false,
                            ),
                            VerificationWidget(
                              isLast: true,
                              onChanged: (value) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const Snavigate();
                                }));
                              },
                              //focusNode: _code4FocusNode,
                              keyboardnone: TextInputType.none,
                              controller1: code4controller,
                              obscuremode: false,
                            ),
                          ]),
                    ),
                  ]),
                ),
                Text(
                  wrongpin,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffF74242),
                  ),
                ),
                Container(
                  width: screenwidth,
                  height: screenheight - 500,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 26.5,
                    right: 26.5,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffF2F3FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                        padding: const EdgeInsets.only(left: 25, right: 30),
                        child: Row(children: [
                          InkWell(
                              onTap: () {
                                fingerprint();
                              },
                              child: Image.asset('assets/fingerprint.png')),
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
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
