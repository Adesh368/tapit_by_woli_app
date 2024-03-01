import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class AirtimeConfirmPaymentScreen extends StatefulWidget {
  const AirtimeConfirmPaymentScreen({super.key});

  @override
  State<AirtimeConfirmPaymentScreen> createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState
    extends State<AirtimeConfirmPaymentScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();

  void fingerprint() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/Illustration.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Transaction Successful!',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff1E33F4),
                ),
              ),
              Text(
                'Your transaction has been completed successfully',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff666666),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: SizedBox(
                    width: double.infinity,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const Snavigate();
                          }));
                        },
                        child: const NavigateWidget(navigationvalue: 'home'))),
              ),
            ],
          ),
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
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                width: double.infinity,
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
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Network:',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff666666),
                          ),
                        ),
                        Text(
                          'MTN',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1F1F1F),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 5,
                  ),
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
                          '₦100.00',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1F1F1F),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recipient',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff666666),
                          ),
                        ),
                        Text(
                          '08060258151',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1F1F1F),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Commission',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff666666),
                          ),
                        ),
                        Text(
                          '₦2.000',
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
             const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenwidth - 150,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerificationWidget(
                        onChanged: (value) {
                                  if(value.length == 1){
                                    FocusScope.of(context);
                                  }
                                },
                        keyboardnone: TextInputType.number,
                        controller1: code1controller,
                        obscuremode: true,
                      ),
                      VerificationWidget(
                        onChanged: (value) {
                                  if(value.length == 1){
                                    FocusScope.of(context);
                                  }
                                },
                        keyboardnone: TextInputType.number,
                        controller1: code2controller,
                        obscuremode: true,
                      ),
                      VerificationWidget(
                       onChanged: (value) {
                                  if(value.length == 1){
                                    FocusScope.of(context);
                                  }
                                },
                        keyboardnone: TextInputType.number,
                        controller1: code3controller,
                        obscuremode: true,
                      ),
                      VerificationWidget(
                        onChanged: (value) {
                                  if(value.length == 1){
                                    FocusScope.of(context);
                                  }
                                },
                        keyboardnone: TextInputType.number,
                        controller1: code4controller,
                        obscuremode: true,
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  fingerprint();
                },
                child:
                   const Padding(
                      padding:  EdgeInsets.only(left: 20,right: 20),
                      child:  NavigateWidget(navigationvalue: 'Confirm Payment'),
                    )),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  //verifycode();
                },
                child: const Padding(
                 padding:  EdgeInsets.only(left: 20,right: 20),
                  child:  NavigateWidget(
                      navigationvalue: 'Use Biometric'),
                )), //buttonvalue
          ]),
        ),
      ),
    );
  }
}
