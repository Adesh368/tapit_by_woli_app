import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/providers/get_transaction.dart';
import 'package:tapit_by_wolid_app/providers/planslist.dart';
import 'package:tapit_by_wolid_app/providers/airtime.dart';
import 'package:tapit_by_wolid_app/providers/data.dart';
import 'package:tapit_by_wolid_app/providers/refresh_indicator.dart';
import 'package:tapit_by_wolid_app/providers/settings.dart';
import 'package:tapit_by_wolid_app/providers/sign_up_provider.dart';
import 'package:tapit_by_wolid_app/screens/splash_screen.dart';
import 'package:tapit_by_wolid_app/providers/sign_in_provider.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xff1E33F4));
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => TapitProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => AirtimeProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => GetUserDetailsProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => DataProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => GetTransactionProvider(),
        ),
      ],
      child: Consumer<TapitProvider>(
        builder: (ctx, tapitProvider, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: const SplashScreen(),
        ),
      ),
    ),
  );
}
