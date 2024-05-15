import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class ConfirmTransactionScreen extends StatefulWidget {
  const ConfirmTransactionScreen({super.key});

  @override
  State<ConfirmTransactionScreen> createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState extends State<ConfirmTransactionScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();

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
            color: Color(0xff001533),
          ),
        ),
      ),
    );
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
                child: Icon(Icons.cancel)),
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Container(
                  // padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  child: const NavigateWidget(navigationvalue: 'Use PIN')),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 25, top: 11),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back)),
                    Text(
                      'Confirm payment',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                    const SizedBox(),
                  ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Enter your PIN',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xff1A1A1A),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please enter your PIN to confirm the \ntransaction.',
              textAlign: TextAlign.center,
              softWrap: true,
              style: GoogleFonts.mulish(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff666666),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: screenheight - 700,
                decoration: BoxDecoration(
                  color: const Color(0xffE6E9FF),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: const Border(
                      top: BorderSide(
                        color: Color(0xffA3ABFE),
                        width: 2.0,
                      ),
                      left: BorderSide(color: Color(0xffA3ABFE), width: 2.0),
                      right: BorderSide(color: Color(0xffA3ABFE), width: 2.0),
                      bottom: BorderSide(color: Color(0xffA3ABFE), width: 2.0)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number:',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff666666),
                              ),
                            ),
                            Text(
                              '09021284572',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff1F1F1F),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount:',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff666666),
                              ),
                            ),
                            Text(
                              '₦1,000',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff1F1F1F),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction fee:',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff666666),
                              ),
                            ),
                            Text(
                              '₦0.00',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff1F1F1F),
                              ),
                            ),
                          ]),
                    ]),
              ),
            ),
            Container(
              width: screenwidth - 150,
              padding: const EdgeInsets.only(top: 20),
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
                      keyboardnone: TextInputType.none,
                      controller1: code4controller,
                      obscuremode: true,
                    ),
                  ]),
            ),
            //buttonvalue
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: screenheight - 500,
                width: screenwidth,
                padding: const EdgeInsets.only(
                    top: 10, left: 26, right: 26, bottom: 20),
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
                        padding: const EdgeInsets.only(left: 35, right: 30),
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
