import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class ManagePinScreen extends StatefulWidget {
  const ManagePinScreen({super.key});

  @override
  State<ManagePinScreen> createState() => _ManagePinScreenState();
}

class _ManagePinScreenState extends State<ManagePinScreen> {
  final _pincontroller = TextEditingController();
  final _pintextinputtype = TextInputType.text;
  final _newpincontroller = TextEditingController();
  final _newpintextinputtype = TextInputType.text;
  final _cnewpincontroller = TextEditingController();
  final _cnewpintextinputtype = TextInputType.text;


  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: screenwidth-20,
            height: screenheight,
            padding: const EdgeInsets.only(bottom: 20, top: 15),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                  
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0xff2D2D2D),
                            )),
                        Text(
                          'Manage Pin',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1A1A1A),
                          ),
                        ),
                        const SizedBox(),
                      ]),
                      const SizedBox(height: 15,),
                      Text(
                          softWrap: true,
                          style: GoogleFonts.mulish(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff666666),
                          ),
                          'A 4-digit has been sent to the phone number and email attached to this account.Please input it as the first details.'),
                          const SizedBox(height: 20,),
                      TextFieldWidget(
                          controller: _pincontroller,
                          title: 'Pin',
                          labeled: '****',
                          textInputType: _pintextinputtype,
                          textobsure: true),
                            const SizedBox(height: 10,),
                      TextFieldWidget(
                          controller: _newpincontroller,
                          title: 'New Pin',
                          labeled: '****',
                          textInputType: _newpintextinputtype,
                          textobsure: true),
                            const SizedBox(height: 10,),
                      TextFieldWidget(
                          controller: _cnewpincontroller,
                          title: 'Confirm New Pin',
                          labeled: '****',
                          textInputType: _cnewpintextinputtype,
                          textobsure: true),
                          const SizedBox(height: 10,),         
                    ]),
                  ),
                ),
                const NavigateWidget(navigationvalue: 'save') ,
              ]
            ),
          ),
        ),
      ),
    );
  }
}
