import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/verification_widget.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({
    required this.mail,
    super.key,
  });

  final String mail;
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

  // Verify Receive Code Method
  Future verifyCode() async {
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
            'email': widget.mail,
            'code': allFourCode,
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const SetPinScreen();
        }));
      } else {
        return;
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Reverify Mail Method
  Future reVerifyMail() async {
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
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      return response;
    } catch (e) {
      rethrow;
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
                      child: Text(
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
                      verifyCode();
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
