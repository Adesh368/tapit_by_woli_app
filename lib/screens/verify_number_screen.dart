import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({
    required this.mail,
    super.key,
  });

  final String mail;
  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  //controllervariable
  final code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String allfourcode = '';
  //verifycodeandmailfunction
  Future verifycode() async {
    setState(() {
      allfourcode = code1controller.text;
      allfourcode = code2controller.text;
      allfourcode = code3controller.text;
      allfourcode = code4controller.text;
    });
    final emailcodeurl = Uri.parse('https://api.tapit.ng/api/auth/verifyemail');
    // final authmodell =
    //    Provider.of<TapitProvider>(context, listen: false).listofname!;
    try {
      final verifycoderesponse = await http.post(
        emailcodeurl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'email': widget.mail,
            'code': allfourcode,
          },
        ),
      );
      final coderesponsedata = jsonDecode(verifycoderesponse.body);
      print(coderesponsedata);
      if (verifycoderesponse.statusCode == 200) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const SetPinScreen();
        }));
      } else {
        return;
      }
      return verifycoderesponse;
    } catch (e) {
      rethrow;
    }
  }

  //sendcodeagainfunction
  Future sendcode() async {
    final authmodel =
        Provider.of<TapitProvider>(context, listen: false).listofname;
    final emailcodeurl = Uri.parse('https://api.tapit.ng/api/auth/verifyemail');
    try {
      final coderesponse = await http.post(
        emailcodeurl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'email': authmodel!.email,
          },
        ),
      );
      final coderesponsedata = jsonDecode(coderesponse.body);
      print(coderesponsedata);
      return coderesponse;
    } catch (e) {
      rethrow;
    }
  }
  //focus variable
  /*
  final _code1FocusNode = FocusNode();
  final _code2FocusNode = FocusNode();
  final _code3FocusNode = FocusNode();
  final _code4FocusNode = FocusNode();
  */

  @override
  Widget build(BuildContext context) {
    final authmodel =
        Provider.of<TapitProvider>(context, listen: false).usernumber;

    final screenwidth = MediaQuery.of(context).size.width;
    final screenhidth = MediaQuery.of(context).size.height;
    // print(screenhidth/2);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: SizedBox(
              height: screenhidth - 500,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(47, 0, 47, 0),
                      child: Image.asset(
                        'assets/enter.png',
                        width: double.infinity,
                      ),
                    ),
                    Text(
                      'Enter the 4-Digit code sent to the mail provided or  +234$authmodel',
                      softWrap: true,
                      //overflow: Alignment.center,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                    SizedBox(
                      width: screenwidth - 150,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VerificationWidget(
                              readonly: false,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.number,
                              controller1: code1controller,
                            ),
                            VerificationWidget(
                              readonly: false,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.number,
                              controller1: code2controller,
                            ),
                            VerificationWidget(
                              readonly: false,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.number,
                              controller1: code3controller,
                            ),
                            VerificationWidget(
                              readonly: false,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context);
                                }
                              },
                              keyboardnone: TextInputType.number,
                              controller1: code4controller,
                            ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn’t receive code?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff666666),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            sendcode();
                          },
                          child: Text(
                            'Send again.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mulish(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1E33F4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          verifycode();
                        },
                        child: const NavigateWidget(navigationvalue: 'verify')),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
