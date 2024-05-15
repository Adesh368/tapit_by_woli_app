import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/providers/sign_in_provider.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/screens/signup_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _namecontroller = TextEditingController();
  final _nametextinputtype = TextInputType.text;
  final _passwordcontroller = TextEditingController();
  final _passwordtextinputtype = TextInputType.text;
  String emptyusername = '';
  String emptypassword = '';
  String errormessage = '';
  String errorpassword = '';
  bool dialogg = false;

  @override
  void dispose() {
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
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

  //savedlogindata
  Future<void> savedLoginData() async {
    final authmodel =
        Provider.of<SignInProvider>(context, listen: false).listofname!;
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
      'image': authmodel.image
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
  }

  // SaveName Method
  /*
  Future<void> saveFirstName() async {
    var userDatas = json.encode({
      'fnamesencode':
          Provider.of<SignInProvider>(context, listen: false).userFirstname,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userfirstname', userDatas);
   
  }
  */

  // SignIn Method
  Future signIn() async {
    dialog();
    final authmodel =
        await Provider.of<SignInProvider>(context, listen: false).userSignIn(
      _namecontroller.text,
      _passwordcontroller.text,
    );
    final responsedata = jsonDecode(authmodel.body);
    //print(responsedata);
    if (authmodel.statusCode == 200) {
      //saveFirstName();
      savedLoginData();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const SetPinScreen();
      }));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      setState(() {
        errormessage = responsedata['message'];
        errorpassword = responsedata['errors']['password'][0];
      });
    }
  }

  // SignIn validation method
  validate() {
    if (_namecontroller.text.isEmpty) {
      setState(() {
        emptyusername = 'Email cannot be empty';
      });
    } else {
      setState(() {
        emptyusername = '';
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
        _passwordcontroller.text.isNotEmpty) {
      signIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: screenheight / 6),
              width: screenwidth - 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      errormessage,
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                    Text(
                      errorpassword,
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldWidget(
                        textobsure: false,
                        emptytextbox: emptyusername,
                        controller: _namecontroller,
                        title: 'Email or Username or Phone Number',
                        labeled: 'Enter your Email or Username',
                        textInputType: _nametextinputtype),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        textobsure: true,
                        emptytextbox: emptypassword,
                        controller: _passwordcontroller,
                        title: 'Password',
                        labeled: '**********',
                        image: Image.asset('assets/view.png'),
                        textInputType: _passwordtextinputtype),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Forget Password?',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.mulish(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff0012B0),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          validate();
                        },
                        child:
                            const NavigateWidget(navigationvalue: 'Sign In')),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                            return const SignUpScreen();
                          }));
                        },
                        child: const TextFontWidget(
                          text: 'Do not have an account? Sign up',
                          sizes: 18,
                          color: Color(0xff0012B0),
                          weights: FontWeight.w700,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
