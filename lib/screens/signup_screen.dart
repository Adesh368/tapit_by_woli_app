import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/screens/verify_number_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _namecontroller = TextEditingController();
  final _nametextinputtype = TextInputType.name;
  final _emailcontroller = TextEditingController();
  final _emailtextinputtype = TextInputType.emailAddress;
  final _usernamecontroller = TextEditingController();
  final _usernametextinputtype = TextInputType.text;
  final _numbercontroller = TextEditingController();
  final _numbertextinputtype = TextInputType.number;
  final _passwordcontroller = TextEditingController();
  final _passwordtextinputtype = TextInputType.text;
  bool _response = false;
  String errormessage = '';

  Future<void> saveemail() async {
    var userDatas = json.encode({
      'fnames': _emailcontroller.text,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
    // print('Hello');
  }

  //sendcodefunction
  Future sendcode() async {
    final emailcodeurl = Uri.parse('https://api.tapit.ng/api/auth/verifyemail');
    try {
      final coderesponse = await http.post(
        emailcodeurl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'email': _emailcontroller.text,
          },
        ),
      );
      final coderesponsedata = jsonDecode(coderesponse.body);
      print(coderesponsedata);
      return coderesponse;
    } catch (e) {
      rethrow;
    }
  }

  Future registerinput() async {
    setState(() {
      _response = true;
    });

    final authmodel = await Provider.of<TapitProvider>(context, listen: false)
        .userinput(
            firstnamed: _namecontroller.text,
            emaild: _emailcontroller.text,
            usernamed: _usernamecontroller.text,
            phonenumberd: _numbercontroller.text,
            passwordd: _passwordcontroller.text);
    final responsedata = jsonDecode(authmodel.body);
    print(responsedata);
    
  
    setState(() {
      _response = false;
    });
    print(authmodel.statusCode);
    if (authmodel.statusCode == 200) {
      saveemail();
      sendcode();
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return VerifyNumberScreen(
          mail: _emailcontroller.text,
        );
      }));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          //title: Text(emailexist),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                      },
                      child: Icon(Icons.cancel)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (responsedata['errors']['email'] != null)
                Text(
                  responsedata['errors']['email'][0],
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
              if (responsedata['errors']['username'] != null)
                Text(
                  responsedata['errors']['username'][0],
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
              if (responsedata['errors']['password'] != null)
                Text(
                  responsedata['errors']['password'][0],
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
              if (responsedata['errors']['phone'] != null)
                Text(
                  responsedata['errors']['phone'][0],
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
            ],
          ),
        ),
      );

      //usernameonly
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: screenwidth - 60,
              child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/signup.png',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // textfield widget
                    TextFieldWidget(
                        textobsure: false,
                        controller: _namecontroller,
                        title: 'Full name',
                        labeled: 'Enter your full name',
                        textInputType: _nametextinputtype),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        textobsure: false,
                        controller: _emailcontroller,
                        title: 'Email',
                        labeled: 'Enter your email',
                        textInputType: _emailtextinputtype),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        textobsure: false,
                        controller: _usernamecontroller,
                        title: 'Username',
                        labeled: 'Choose a username',
                        textInputType: _usernametextinputtype),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        maxword: [
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textobsure: false,
                        controller: _numbercontroller,
                        title: 'Phone number',
                        labeled: 'Enter your phone number',
                        textInputType: _numbertextinputtype),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        textobsure: true,
                        controller: _passwordcontroller,
                        title: 'Password',
                        labeled: '**********',
                        image: Image.asset('assets/view.png'),
                        textInputType: _passwordtextinputtype),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          registerinput();
                        },
                        child: _response
                            ? Center(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
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
                                        child: CircularProgressIndicator())),
                              )
                            : const NavigateWidget(
                                navigationvalue: 'Create your account')),
                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const SignInScreen();
                        }));
                      },
                      child: const Center(
                        child: TextFontWidget(
                          text: 'Already have account? Login',
                          sizes: 16,
                          color: Color(0xff1E33F4),
                          weights: FontWeight.w600,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
