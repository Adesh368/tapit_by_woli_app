import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/providers/data.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class DataConfirmPaymentScreen extends StatefulWidget {
  const DataConfirmPaymentScreen(
      {required this.amount,
      required this.network,
      required this.phone,
      required this.plan,
      required this.planid,
      super.key});

  final String network;
  final String phone;
  final String plan;
  final String amount;
  final String planid;
  @override
  State<DataConfirmPaymentScreen> createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState extends State<DataConfirmPaymentScreen> {
  TextEditingController code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String? onSelectNetwork;
  bool _response = false;
  bool _status = false;
  String? status;
  String? isChecked;
  String? pin1;
  String? pin2;
  String? pin3;
  String? pin4;
  String wrongpin = '';
  String? token;
  String? firstName;

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
      firstName = extracteduserdata['fname'];
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
        builder: (ctx) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_status) Image.asset('assets/Illustration.png'),
                  if (status == 'fail') Image.asset('assets/Illustration1.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_status)
                    Text(
                      'Transaction Successful!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1E33F4)),
                    ),
                  if (status == 'fail')
                    Text(
                      'Transaction Failed!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffEC1A23),
                      ),
                    ),
                    if (_status)
                    Text(
                      'Your transaction has been completed successfully.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1E33F4)),
                    ),
                    if (status == 'fail')
                    Text(
                      'Your transaction has not been completed.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffEC1A23),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: SizedBox(
                        width: double.infinity,
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return const Snavigate();
                              }));
                            },
                            child:
                                const NavigateWidget(navigationvalue: 'home'))),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //airtimerequest
  Future dataRequest() async {
    if (code1controller.text.isEmpty ||
        code2controller.text.isEmpty ||
        code3controller.text.isEmpty ||
        code4controller.text.isEmpty) {
      setState(() {
        wrongpin = 'PIN cannot be empty!';
      });
      return;
    }
    // final authmodel = Provider.of<TapitProvider>(context, listen: false).listofname!;
    if (widget.network == 'MTN') {
      setState(() {
        onSelectNetwork = '1';
      });
    }

    if (widget.network == 'Glo') {
      setState(() {
        onSelectNetwork = '4';
      });
    }
    if (widget.network == 'Airtel') {
      setState(() {
        onSelectNetwork = '2';
      });
    }
    if (widget.network == '9mobile') {
      setState(() {
        onSelectNetwork = '3';
      });
    }
    if (code1controller.text == pin1 &&
        code2controller.text == pin2 &&
        code3controller.text == pin3 &&
        code4controller.text == pin4) {
      setState(() {
        _response = true;
      });
      final auth = await Provider.of<DataProvider>(context, listen: false)
          .requestData(
              token: token.toString(),
              amount: widget.amount,
              plan: widget.plan,
              firstName: firstName.toString(),
              onSelectNetwork: onSelectNetwork.toString(),
              phone: widget.phone);
      final responsedata = jsonDecode(auth.body);
      setState(() {
        _response = false;
      });
      //print(responsedata);
      if (auth.statusCode == 200) {
        setState(() {
          _status = responsedata['data']['status'];
        });
      } else {
        setState(() {
          status = responsedata['status'];
        });
      }
      isLoding();
    } else {
      setState(() {
        wrongpin = 'PIN does not match!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      style:Theme.of(context)
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
                          widget.network,
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
                          'Plan',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff666666),
                          ),
                        ),
                        Text(
                          widget.planid,
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
                          '₦${widget.amount}',
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
                          widget.phone,
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
                          'commision',
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
                      readonly: false,
                      keyboardnone: TextInputType.number,
                      controller1: code1controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      readonly: false,
                      keyboardnone: TextInputType.number,
                      controller1: code2controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      readonly: false,
                      keyboardnone: TextInputType.number,
                      controller1: code3controller,
                      obscuremode: true,
                    ),
                    VerificationWidget(
                      readonly: false,
                      keyboardnone: TextInputType.number,
                      controller1: code4controller,
                      obscuremode: true,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  dataRequest();
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
                                child: CircularProgressIndicator(
                              color: Color(0xffffffff),
                            ))),
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
