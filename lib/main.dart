import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/airtime_confirm_payment_screen.dart';
import 'package:tapit_by_wolid_app/screens/bottomnav_screen.dart';
import 'package:tapit_by_wolid_app/screens/buy_airtime_screen.dart';
import 'package:tapit_by_wolid_app/screens/confirm_trans_screen.dart';
import 'package:tapit_by_wolid_app/screens/home_page.dart';
import 'package:tapit_by_wolid_app/screens/login_screen.dart';
import 'package:tapit_by_wolid_app/screens/setpin_screen.dart';
import 'package:tapit_by_wolid_app/screens/sign_in_screen.dart';
import 'package:tapit_by_wolid_app/screens/signup_screen.dart';
import 'package:tapit_by_wolid_app/screens/splash_screen.dart';
import 'package:tapit_by_wolid_app/screens/transaction_screen.dart';
import 'package:tapit_by_wolid_app/screens/verify_number_screen.dart';
import 'package:tapit_by_wolid_app/screens/verify_pin_screen.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => TapitProvider(),
          // value:Products(),
        ),
      ],
      child: Consumer<TapitProvider>(
        builder: (ctx, tapitProvider, _) =>const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    ),);
}

