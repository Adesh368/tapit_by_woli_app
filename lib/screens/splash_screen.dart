import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';
import 'package:tapit_by_wolid_app/screens/welcome_screen.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  String? userpin;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getValidatedata().whenComplete(() async {
      Timer(const Duration(seconds: 10), () {
        if (userpin == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const WelcomeScreen();
          }));
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const LoginScreen();
          }));
        }
      });
    });

    super.initState();
  }

  //validatefunction
  Future<void> getValidatedata() async {
    final prefs = await SharedPreferences.getInstance();

    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      userpin = extracteduserdata['fnames'];
    });
    print(extracteduserdata['fnames']);
    print(userpin);
    print('helo');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset('assets/taplogo.png')),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, screeheight - 782),
              child: Center(
                child: SizedBox(
                  width: screenwidth - 312,
                  child: const Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
