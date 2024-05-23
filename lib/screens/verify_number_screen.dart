import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen([this.mail, Key? key]) : super(key: key);

  final String? mail;
  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final code1controller = TextEditingController();
  final code2controller = TextEditingController();
  final code3controller = TextEditingController();
  final code4controller = TextEditingController();
  String allFourCode = '';
  String? mail;
  String? phone;
  String? errormessage;
  bool isLoadig = false;

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  @override
  void dispose() {
    code1controller.dispose();
    code2controller.dispose();
    code3controller.dispose();
    code4controller.dispose();
    super.dispose();
  }

  Future<void> getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      mail = extracteduserdata['email'];
      phone = extracteduserdata['phone'];
    });
  }

  // Validate onboarding screen
  Future<void> _saved() async {
    var userDatas = json.encode({
      'verify': 'check',
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('verifyemail', userDatas);
  }

  // Dialog Method
  dialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  // Verify Receive Code Method
  Future verifyCode() async {
    dialog();
    setState(() {
      allFourCode = code1controller.text;
      allFourCode = code2controller.text;
      allFourCode = code3controller.text;
      allFourCode = code4controller.text;
    });
    final emailcodeurl = Uri.parse('https://api.tapit.ng/api/auth/verifyemail');
    try {
      final response = await http.post(
        emailcodeurl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'email': mail,
            'code': allFourCode,
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      if (response.statusCode == 200) {
        _saved();
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const SetPinScreen();
        }));
      } else {
        setState(() {
          errormessage = 'Incorrect code';
        });
      }
      // return response;
    } catch (e) {
      rethrow;
    }
  }

  // Reverify Mail Method
  Future reVerifyMail() async {
    setState(() {
      isLoadig = true;
    });
    //final authmodel = Provider.of<SignUpProvider>(context, listen: false).listofname;
    final url = Uri.parse('https://api.tapit.ng/api/auth/verifyemail');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'email': mail,
          },
        ),
      );
      setState(() {
        isLoadig = false;
      });
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  _validate() {
    if (code1controller.text.isEmpty ||
        code2controller.text.isEmpty ||
        code3controller.text.isEmpty ||
        code4controller.text.isEmpty) {
      setState(() {
        errormessage = 'Fields cannot be empty';
      });
    } else {
      verifyCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final authmodel = Provider.of<SignUpProvider>(context, listen: false).usernumber;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                Image.asset(
                  'assets/enter.png',
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (errormessage != null)
                  Text(
                    errormessage.toString(),
                    style: GoogleFonts.mulish(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF74242),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter the 4-Digit code sent to the mail \n provided or  +234$phone',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        VerificationWidget(
                          readonly: false,
                          keyboardnone: TextInputType.number,
                          controller1: code1controller,
                        ),
                        VerificationWidget(
                          readonly: false,
                          keyboardnone: TextInputType.number,
                          controller1: code2controller,
                        ),
                        VerificationWidget(
                          readonly: false,
                          keyboardnone: TextInputType.number,
                          controller1: code3controller,
                        ),
                        VerificationWidget(
                          readonly: false,
                          keyboardnone: TextInputType.number,
                          controller1: code4controller,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn’t receive code?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        reVerifyMail();
                      },
                      child: isLoadig
                          ? Text(
                              'sending...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: const Color(0xff1E33F4)),
                            )
                          : Text(
                              'Send again.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: const Color(0xff1E33F4)),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      _validate();
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
