import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
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
  String isEmpty = '';
  @override
  void dispose() {
    code1controller.dispose();
    code2controller.dispose();
    code3controller.dispose();
    code4controller.dispose();
    super.dispose();
  }

  // SetPin Method
  Future<void> onSetPin() async {
    if (code1controller.text.isEmpty ||
        code2controller.text.isEmpty ||
        code3controller.text.isEmpty ||
        code4controller.text.isEmpty) {
      setState(() {
        isEmpty = 'field must not be empty';
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const Snavigate();
      }));
      var userDatas = json.encode({
        'controller1': code1controller.text,
        'controller2': code2controller.text,
        'controller3': code3controller.text,
        'controller4': code4controller.text,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('usercode', userDatas);
    }
  }

  // Calculator Method
  void valuefunction(String btnvalue) {
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
    }
  }

  // Calculator Button widegt
  Widget buttons(String btntxt) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          valuefunction(btntxt);
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
        child: Padding(
          padding: const EdgeInsets.only(top: 80, bottom: 10),
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 85, right: 85),
                      child: Image.asset(
                        'assets/setpin.png',
                        width: double.infinity,
                      )),
                  Text(
                    isEmpty,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF74242),
                    ),
                  ),
                  Text(
                    'Choose a 4-Digit Pin to login and \ncomplete transactions.',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 85, right: 85, top: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VerificationWidget(
                            keyboardnone: TextInputType.none,
                            controller1: code1controller,
                            obscuremode: false,
                          ),
                          VerificationWidget(
                            keyboardnone: TextInputType.none,
                            controller1: code2controller,
                            obscuremode: false,
                          ),
                          VerificationWidget(
                            keyboardnone: TextInputType.none,
                            controller1: code3controller,
                            obscuremode: false,
                          ),
                          VerificationWidget(
                            keyboardnone: TextInputType.none,
                            controller1: code4controller,
                            obscuremode: false,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              height: screenheight * 0.4,
              width: screenwidth,
              decoration: const BoxDecoration(
                color: Color(0xffF2F3FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Button value Widget
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 70,
                            ),
                            buttons('0'),
                            //Clear Button Method
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
                            const SizedBox(
                              width: 35,
                            ),
                          ]),
                      InkWell(
                        onTap: () {
                          onSetPin();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: NavigateWidget(navigationvalue: 'Set PIN'),
                        ),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
