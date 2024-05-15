import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/screens/onboarding_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? userName;
  String? onboardData;
  String? userFourPin;

  // Get Saved Data Method
  Future<void> getValidatedata() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata =
        json.decode(prefs.getString('useremail').toString());
    var validateOnboardingScreen =
        json.decode(prefs.getString('validate').toString());
    var validateSetPinScreen =
        json.decode(prefs.getString('usercode').toString());
    if (extracteduserdata != null) {
      setState(() {
        userName = extracteduserdata['fnames'];
      });
    }
    if (validateOnboardingScreen != null) {
      setState(() {
        onboardData = validateOnboardingScreen['onboard'];
      });
    }
    if (validateSetPinScreen != null) {
      setState(() {
        userFourPin = validateSetPinScreen['controller1'];
      });
    }
  }

  // Navigation Method
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getValidatedata().whenComplete(() async {
      Timer(const Duration(seconds: 10), () {
        if (userName == null || onboardData == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const OnboardingScreen();
          }));
        }
        if (onboardData != null && userName != null && userFourPin != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const LoginScreen();
          }));
        }
        if (onboardData != null && userName == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const SignInScreen();
          }));
        }
        if (onboardData != null && userName != null && userFourPin == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const SetPinScreen();
          }));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screeheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenwidth,
        height: screeheight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset('assets/taplogo.png')),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Column(
                  children: [
                    TextFontWidget(
                      text: 'from',
                      sizes: 14,
                      color: Color(0xff1F1F1F),
                      weights: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFontWidget(
                      text: 'WOLID',
                      sizes: 18,
                      color: Color(0xff1E33F4),
                      weights: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
