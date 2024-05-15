import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/providers/planslist.dart';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  String? firstname;
  String? password;
  String? accountNumber;
  String? bankName;

  @override
  void initState() {
    getValidatedata();
    super.initState();
  }

  Future<void> getValidatedata() async {
    final prefs = await SharedPreferences.getInstance();

    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      firstname = extracteduserdata['fnames'];
      password = extracteduserdata['lname'];
      accountNumber = extracteduserdata['accountnumber'];
      bankName = extracteduserdata['bankname'];
    });
    
  }
  @override
  Widget build(BuildContext context) {
    // final automod = Provider.of<TapitProvider>(context, listen: false).listofname!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
              Text(
                'Bank Transfer',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A1A1A),
                ),
              ),
              const SizedBox(),
            ]),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your personalized bank account details is shown below. Copy the account details to fund your wallet.',
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Name',
                                    style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff666666),
                                    )),
                                Text(firstname.toString(),
                                    style: GoogleFonts.mulish(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff1F1F1F),
                                    )),
                              ]),
                          InkWell(
                              onTap: () {
                                
                                Clipboard.setData(
                                    ClipboardData(text: accountNumber.toString()));
                                    
                              },
                              child: Image.asset('assets/copy.png')),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Number',
                              style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff666666),
                              )),
                          Text(accountNumber.toString(),
                              style: GoogleFonts.mulish(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff1F1F1F),
                              )),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Bank',
                              style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff666666),
                              )),
                          Text(bankName.toString(),
                              style: GoogleFonts.mulish(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff1F1F1F),
                              )),
                        ]),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
