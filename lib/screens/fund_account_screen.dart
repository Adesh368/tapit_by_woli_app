import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/bank_trnasfer_screen.dart';

class FundAccountScreen extends StatelessWidget {
  const FundAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
              Text(
                'Fund Account',
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
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const BankTransferScreen();
                }));
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffE6E9FF),
                    border:
                        Border.all(width: 2, color: const Color(0xffE6E9FF))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/banktransfer.png'),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bank transfer',
                            style: GoogleFonts.mulish(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff1A1A1A),
                            ),
                          ),
                          Text(
                            'Transfer money to your personalized \nbank account.',
                            style: GoogleFonts.mulish(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff666666),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
