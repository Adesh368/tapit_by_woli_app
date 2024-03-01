import 'package:flutter/material.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/screens/signup_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screeheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: screeheight - 220,
                width: screenwidth,
                child: Image.asset(
                  'assets/welcome.png',
                  fit: BoxFit.cover,
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const SignUpScreen();
                  }));
                },
                child: const Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10),
                  child:  NavigateWidget(
                      navigationvalue: 'Create your account'),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: screeheight - 770),
              child: InkWell(
                onTap: () {
                  
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const LoginScreen();
                  }));
                  
                },
                child: InkWell(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
