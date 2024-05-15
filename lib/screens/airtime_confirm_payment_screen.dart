import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tapit_by_wolid_app/providers/airtime.dart';
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
  String? onSelectNetwork;
  bool _response = false;
  String? _status;
  String? pin1;
  String? pin2;
  String? pin3;
  String? pin4;
  String wrongpin = '';
  String? token;
  @override
  void initState() {
    getSavedBalance();
    onVerify();
    super.initState();
  }

  Future<void> getSavedBalance() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      token = extracteduserdata['token'];
    });
  }

  Future<void> onVerify() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('usercode')!);
    setState(() {
      pin1 = extracteduserdata['controller1'];
      pin2 = extracteduserdata['controller2'];
      pin3 = extracteduserdata['controller3'];
      pin4 = extracteduserdata['controller4'];
    });
  }

  //fingerprintfunction
  void isLoding() {
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
              Image.asset(_status == 'fail'
                  ? 'assets/Illustration1.png'
                  : 'assets/Illustration.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                _status == 'fail'
                    ? 'Transaction Failed!'
                    : 'Transaction Successful!',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _status == 'fail'
                      ? const Color(0xffEC1A23)
                      : const Color(0xff1e33f4),
                ),
              ),
              Text(
                _status == 'fail'
                    ? 'Your transaction has not been completed.'
                    : 'Your transaction has been completed successfully.',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _status == 'fail'
                      ? const Color(0xffEC1A23)
                      : const Color(0xff1e33f4),
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

  // Buy Airtime Request Method
  Future airtimeRequest() async {
    if (code1controller.text == pin1 &&
        code2controller.text == pin2 &&
        code3controller.text == pin3 &&
        code4controller.text == pin4) {
      setState(() {
        _response = true;
      });
       final authmodel = Provider.of<AirtimeProvider>(context, listen: false).userDetails!;
      final auths = await Provider.of<AirtimeProvider>(context, listen: false)
          .airtimeRequest(
              token: token.toString(),
              phone: authmodel.phone,
              amount: authmodel.amount,
              onSelectNetwork: onSelectNetwork.toString());
      final responsedata = jsonDecode(auths.body);
      print(responsedata);
      if (auths.statusCode == 200) {
        setState(() {
            _response = false;
          _status = responsedata['status'];
        });
      } else {
        setState(() {
          _response = false;
          _status = responsedata['status'];
        });
      }
      isLoding();
    } else {
      setState(() {
        wrongpin = 'PIN did not match!';
      });
    }
    // print(wrongpin);
  }

  // Validate Method
  validate() {
    if (code1controller.text.isEmpty ||
        code2controller.text.isEmpty ||
        code3controller.text.isEmpty ||
        code4controller.text.isEmpty) {
      setState(() {
        wrongpin = 'PIN cannot be empty!';
      });
       return;
    } 
    
    final authmodel =
        Provider.of<AirtimeProvider>(context, listen: false).userDetails!;
    if (authmodel.network == 'MTN') {
      setState(() {
        onSelectNetwork = '1';
      });
    } else if (authmodel.network == 'Glo') {
      setState(() {
        onSelectNetwork = '4';
      });
    } else if (authmodel.network == 'Airtel') {
      setState(() {
        onSelectNetwork = '2';
      });
    } else if (authmodel.network == '9mobile') {
      setState(() {
        onSelectNetwork = '3';
      });
    }
   airtimeRequest();
  }


  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final authmodel =
        Provider.of<AirtimeProvider>(context, listen: false).userDetails!;
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
                      style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                    ),
                    const SizedBox(),
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
                          authmodel.network,
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
                          '₦${authmodel.amount}',
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
                          authmodel.phone,
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
                          authmodel.commission,
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
            Padding(
              padding: const EdgeInsets.only(left: 85, right: 85),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerificationWidget(
                      keyboardnone: TextInputType.number,
                      controller1: code1controller,
                      obscuremode: true,
                      readonly: false,
                    ),
                    VerificationWidget(
                      keyboardnone: TextInputType.number,
                      controller1: code2controller,
                      obscuremode: true,
                      readonly: false,
                    ),
                    VerificationWidget(
                      keyboardnone: TextInputType.number,
                      controller1: code3controller,
                      obscuremode: true,
                      readonly: false,
                    ),
                    VerificationWidget(
                      keyboardnone: TextInputType.number,
                      controller1: code4controller,
                      obscuremode: true,
                      readonly: false,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  validate();
                },
                child: _response
                    ? Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            width: screenwidth - 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xff1E33F4),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffF5F5FF),
                              ),
                            ),
                            child: const Center(
                                child: CircularProgressIndicator(color: Color(0xffffffff),))),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child:
                            NavigateWidget(navigationvalue: 'Confirm Payment'),
                      )),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  //fingerprint();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: NavigateWidget(navigationvalue: 'Use Biometric'),
                )), //buttonvalue
          ]),
        ),
      ),
    );
  }
}
