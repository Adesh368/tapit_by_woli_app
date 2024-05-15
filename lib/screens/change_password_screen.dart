import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _pincontroller = TextEditingController();
  final _pintextinputtype = TextInputType.text;
  final _newpincontroller = TextEditingController();
  final _newpintextinputtype = TextInputType.text;
  final _cnewpincontroller = TextEditingController();
  final _cnewpintextinputtype = TextInputType.text;
  String isEmpty = '';

  validateData(){
    if(_pincontroller.text.isEmpty || _newpincontroller.text.isEmpty || _cnewpincontroller.text.isEmpty){
      setState(() {
        isEmpty='All fields are required and must be 6';
      });
    }
  }

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
                          'Change password',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1A1A1A),
                          ),
                        ),
                        const SizedBox(),
                      ]),
                      Text(
                          isEmpty,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 233, 9, 9),
                          ),
                        ),
                      const SizedBox(height: 15,),
                      TextFieldWidget(
                          controller: _pincontroller,
                          title: 'Password',
                          labeled: '******',
                          textInputType: _pintextinputtype,
                          textobsure: true),
                            const SizedBox(height: 10,),
                      TextFieldWidget(
                          controller: _newpincontroller,
                          title: 'New Password',
                          labeled: '******',
                          textInputType: _newpintextinputtype,
                          textobsure: true),
                            const SizedBox(height: 10,),
                      TextFieldWidget(
                          controller: _cnewpincontroller,
                          title: 'Confirm New Password',
                          labeled: '******',
                          textInputType: _cnewpintextinputtype,
                          textobsure: true),
                          const SizedBox(height: 10,),         
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    validateData();
                  },
                  child: const NavigateWidget(navigationvalue: 'save')) ,
              ]
            ),
          ),
        ),
      ),
    );
  }
}
