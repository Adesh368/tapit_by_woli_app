import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/screens/signup_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Validate onboarding screen
   Future<void> onSaved() async {
    var userDatas = json.encode({
      'onboard': 'check',
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('validate', userDatas);
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screeheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: screeheight*0.8,
                width: screenwidth,
                child: Image.asset(
                  'assets/welcome.png',
                  fit: BoxFit.cover,
                )),
            InkWell(
                onTap: () {
                  onSaved();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const SignUpScreen();
                  }));
                },
                child: const Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10),
                  child:  NavigateWidget(
                      navigationvalue: 'Create your account'),
                )),
            InkWell(
              onTap: () {
                onSaved();
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
                return const SignInScreen();
              }));
              },
              child: const TextFontWidget(
                text: 'Already have account? Login',
                sizes: 16,
                color: Color(0xff1E33F4),
                weights: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
