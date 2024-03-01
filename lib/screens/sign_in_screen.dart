import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/screens/signup_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';
import 'package:transparent_image/transparent_image.dart';

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
  //bool _response = false;


  dialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return  AlertDialog(
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
  
 Future<void> saveemail() async {
    var userDatas = json.encode({
      'fnames': _namecontroller.text,
       'lname': _passwordcontroller.text,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', userDatas);
    print('Hello');
  }

  Future<void> saveFirstName() async {
    var userDatas = json.encode({
      'fnamesencode': Provider.of<TapitProvider>(context, listen: false).userfirstname,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userfirstname', userDatas);
    print('Hii');
  }
  //logintohomepage
  Future userlogins() async {
    dialog();
    final authmodel =
        await Provider.of<TapitProvider>(context, listen: false).userlogins(
      _namecontroller.text,
      _passwordcontroller.text,
    );
    final responsedata = jsonDecode(authmodel.body);
    print(responsedata);
    
    
    if (authmodel.statusCode == 200) {
      saveFirstName();
      saveemail();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const Snavigate();
      }));
    } else {
      return;
    }
  }

  //validatelogin
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
    if (_namecontroller.text.isNotEmpty ||
        _passwordcontroller.text.isNotEmpty) {
      userlogins();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenwidth,
            child: Stack(children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage('assets/background.png'),
                height: screenheight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 200,
                top: 180,
                left: 20,
                right: 20,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
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
                        Text(
                          'Forget Password?',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.mulish(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff0012B0),
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
                            sizes: 16,
                            color: Color(0xff0012B0),
                            weights: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
