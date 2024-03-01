import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/confirm_trans_screen.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class BvnVerificationScreen extends StatefulWidget {
  const BvnVerificationScreen({super.key});

  @override
  State<BvnVerificationScreen> createState() => _BvnVerificationScreenState();
}

class _BvnVerificationScreenState extends State<BvnVerificationScreen> {
  final _numbercontroller = TextEditingController();
  final _numbertextinputtype = TextInputType.number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back)),
                Text(
                  'Verify BVN',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
                const SizedBox(),
              ],
            ),
             Text(
              'BVN Verifiction',
              style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1E33F4),
                  ),
            ),
             Text(
                'Your provided details help us provide you with our personalised bank account wallet founding',
                style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A1A1A),
                  ),),
                  const SizedBox(height: 40,),
                 TextFieldWidget(
                 maxword: [LengthLimitingTextInputFormatter(11),
                 FilteringTextInputFormatter.digitsOnly],
                  textobsure: false,
                  controller: _numbercontroller,
                  title: 'Enter your BVN',
                  labeled: '09021284572',
                  textInputType: _numbertextinputtype),
                  Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return const ConfirmTransactionScreen();
                        }));
                      },
                      child:
                          const NavigateWidget(navigationvalue: 'Continue'))),
                          InkWell(
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const SignInScreen();
                  }));
                  },
                  child: const TextFontWidget(
                    text: 'Already have account? Login',
                    sizes: 16,
                    color: Color(0xff1E33F4),
                    weights: FontWeight.w600,
                  ),
                ), 
          ]),
        ),
      ),
    );
  }
}
