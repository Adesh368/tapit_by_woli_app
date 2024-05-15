import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String wrongpin = '';
  String? pin1;
  String? pin2;
  String? pin3;
  String? pin4;
  String? firstName;
  String? passWord;

  @override
  void initState() {
    getValidatedata();
    super.initState();
  }

  @override
  void dispose() {
    code1controller.dispose();
    code2controller.dispose();
    code3controller.dispose();
    code4controller.dispose();
    super.dispose();
  }

  Future<void> getValidatedata() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      firstName = extracteduserdata['fnames'];
      passWord = extracteduserdata['lname'];
    });
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
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const Snavigate();
      }));
    } else {
      setState(() {
        wrongpin = 'PIN did not match!';
      });
    }
  }

  //Finger Print Dialog Method
  void fingerPrint() {
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

  // Calculator Method
  void calculator(String btnvalue) {
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

  // Calculator widegt
  Widget buttons(String btntxt) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          calculator(btntxt);
        },
        child: Text(
          btntxt,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
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
        child: Container(
          width: screenwidth,
          padding: const EdgeInsets.only(top: 70),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 85, right: 85),
                child: Image.asset(
                  'assets/taplogo.png',
                  width: double.infinity,
                )),
            Text(
              'Welcome $firstName',
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Login to your account.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 80, right: 80, top: 20, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerificationWidget(
                      keyboardnone: TextInputType.none,
                      controller1: code1controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      keyboardnone: TextInputType.none,
                      controller1: code2controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      keyboardnone: TextInputType.none,
                      controller1: code3controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      isLast: true,
                      keyboardnone: TextInputType.none,
                      controller1: code4controller,
                      obscuremode: true,
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenwidth,
                  height: screenheight / 2.5,
                  alignment: Alignment.bottomCenter,
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
                                fingerPrint();
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
