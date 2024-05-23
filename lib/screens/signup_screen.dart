import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/providers/sign_up_provider.dart';
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
  String emptyusername = '';
  String emptypassword = '';
  String emptyEmail = '';
  String emptyUserName = '';
  String emptyPhoneNumber = '';

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
    _numbercontroller.dispose();
    super.dispose();
  }

  // Save User DetailS Method
  Future<void> onSaved() async {
    final authmodel =
        Provider.of<SignUpProvider>(context, listen: false).listofname!;
    var userDatas = json.encode({
      'fnames': _namecontroller.text,
      'lname': _passwordcontroller.text,
      'balance': authmodel.amount,
      'username': authmodel.username,
      'token': authmodel.token,
      'lastname': authmodel.lastname,
      'firstname': authmodel.firstname,
      'email': authmodel.email,
      'phone': authmodel.phonenumber,
      'accountnumber': authmodel.accountnumber,
      'bankname': authmodel.bankname,
      'image': authmodel.image,
      'mailscreen': 'code',
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
  }

  // Verify Email Method
  Future verifyMail() async {
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
            'email': _emailcontroller.text,
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Registration Method
  Future onRegister() async {
    setState(() {
      _response = true;
    });
    final authmodel = await Provider.of<SignUpProvider>(context, listen: false)
        .userSignUp(
            firstnamed: _namecontroller.text,
            emaild: _emailcontroller.text,
            usernamed: _usernamecontroller.text,
            phonenumberd: _numbercontroller.text,
            passwordd: _passwordcontroller.text);
    final responsedata = jsonDecode(authmodel.body);
    setState(() {
      _response = false;
    });
    if (authmodel.statusCode == 200) {
      onSaved();
      verifyMail();
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return VerifyNumberScreen(
          _emailcontroller.text,
        );
      }));
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                      },
                      child: const Icon(Icons.cancel)),
                ],
              ),
              const SizedBox(
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
    }
  }

  // SignIn validation method
  validate() {
    if (_namecontroller.text.isEmpty) {
      setState(() {
        emptyusername = 'name cannot be empty';
      });
    } else {
      setState(() {
        emptyusername = '';
      });
    }
    if (_emailcontroller.text.isEmpty) {
      setState(() {
        emptyEmail = 'email cannot be empty';
      });
    } else {
      setState(() {
        emptyEmail = '';
      });
    }
    if (_usernamecontroller.text.isEmpty) {
      setState(() {
        emptyUserName = 'username cannot be empty';
      });
    } else {
      setState(() {
        emptyUserName = '';
      });
    }
    if (_numbercontroller.text.isEmpty) {
      setState(() {
        emptyPhoneNumber = 'phonenumber cannot be empty';
      });
    } else {
      setState(() {
        emptyPhoneNumber = '';
      });
    }
    if (_passwordcontroller.text.isEmpty) {
      setState(() {
        emptypassword = 'password cannot be empty';
      });
    } else {
      setState(() {
        emptypassword = '';
      });
    }
    if (_namecontroller.text.isNotEmpty &&
        _passwordcontroller.text.isNotEmpty &&
        _emailcontroller.text.isNotEmpty &&
        _usernamecontroller.text.isNotEmpty &&
        _numbercontroller.text.isNotEmpty) {
      onRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenhidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              width: screenwidth - 60,
              height: screenhidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/signup.png',
                    ),
                    // Textfield Widget
                    TextFieldWidget(
                        textobsure: false,
                        emptytextbox: emptyusername,
                        controller: _namecontroller,
                        title: 'Full name',
                        labeled: 'Enter your full name',
                        textInputType: _nametextinputtype),
                    TextFieldWidget(
                        textobsure: false,
                        emptytextbox: emptyEmail,
                        controller: _emailcontroller,
                        title: 'Email',
                        labeled: 'Enter your email',
                        textInputType: _emailtextinputtype),
                    TextFieldWidget(
                        emptytextbox: emptyUserName,
                        textobsure: false,
                        controller: _usernamecontroller,
                        title: 'Username',
                        labeled: 'Choose a username',
                        textInputType: _usernametextinputtype),
                    TextFieldWidget(
                        maxword: [
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        emptytextbox: emptyPhoneNumber,
                        textobsure: false,
                        controller: _numbercontroller,
                        title: 'Phone number',
                        labeled: 'Enter your phone number',
                        textInputType: _numbertextinputtype),
                    TextFieldWidget(
                        emptytextbox: emptypassword,
                        textobsure: true,
                        controller: _passwordcontroller,
                        title: 'Password',
                        labeled: '**********',
                        image: Image.asset('assets/view.png'),
                        textInputType: _passwordtextinputtype),
                    InkWell(
                        onTap: () {
                          validate();
                        },
                        child: _response
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                width: screenwidth,
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
                                )))
                            : const NavigateWidget(
                                navigationvalue: 'Create your account')),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
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
