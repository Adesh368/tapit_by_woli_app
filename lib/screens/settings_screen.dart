import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/providers/settings.dart';
import 'package:tapit_by_wolid_app/screens/change_password_screen.dart';
import 'package:tapit_by_wolid_app/screens/managepin_screen.dart';
import 'package:tapit_by_wolid_app/screens/profile_screen.dart';
import 'package:tapit_by_wolid_app/widgets/subsettings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? balance;
  String? username;
  String? firstname;
  String? lastname;
  String? token;
  bool filtered = false;
  bool switchState = false;
  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  Future<void> getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      balance = extracteduserdata['balance'];
      username = extracteduserdata['username'];
      firstname = extracteduserdata['firstname'];
      lastname = extracteduserdata['lastname'];
      token = extracteduserdata['token'];
    });
  }

  void openCameraOverlay() {
    final screenheight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return SizedBox(
          height: screenheight * 0.2,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<SettingsProvider>(context, listen: false)
                          .takePicture(ImageSource.camera, token.toString(),
                              firstname.toString(), lastname.toString());
                      Navigator.of(context).pop();
                    },
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Take a photo',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<SettingsProvider>(context, listen: false)
                          .takePicture(ImageSource.gallery, token.toString(),
                              firstname.toString(), lastname.toString());
                      Navigator.of(context).pop();
                    },
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Choose from Albums',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }

  void _displaystate(bool value) {
    setState(() {
      switchState = !switchState;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff1E33F4),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Color(0xffffffff),
        ),
        height: screenheight * 0.58,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const ProfileScreen();
                    }));
                  },
                  child: const SubSettingsWidget(
                      image: 'assets/profile_icon.png',
                      text: 'Personal Information')),
              SubSettingsWidget(
                image: 'assets/fingerprintt.png',
                text: 'Biometrics',
                icons: Switch(
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.blue,
                  value: switchState,
                  onChanged: _displaystate,
                ),
              ),
              const SubSettingsWidget(
                  image: 'assets/verify.png', text: 'Account Verification'),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const ManagePinScreen();
                  }));
                },
                child: const SubSettingsWidget(
                    image: 'assets/managepin.png', text: 'Manage PIN'),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const ChangePasswordScreen();
                  }));
                },
                child: const SubSettingsWidget(
                    image: 'assets/updatepassword.png',
                    text: 'Update Password'),
              ),
              const SubSettingsWidget(
                  image: 'assets/referral.png', text: 'Referrals'),
              const SubSettingsWidget(
                  image: 'assets/merchant.png', text: 'Upgrade to Merchant'),
              const SubSettingsWidget(
                  image: 'assets/help.png', text: 'Help Center'),
              const SubSettingsWidget(
                  image: 'assets/terms.png', text: 'Terms and Conditions'),
              const SubSettingsWidget(
                  image: 'assets/policy.png', text: 'Privacy Policy'),
              const SubSettingsWidget(image: 'assets/about.png', text: 'About'),
              Text(
                'Logout',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffEC1A23),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1E33F4), Color(0xff1E33F4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffffffff),
                  ),
                ),
                Container(
                  width: 120,
                  height: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(children: [
                    Image.asset(
                      'assets/oval.png',
                      height: double.infinity,
                    ),
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 20,
                      bottom: 0,
                      child: Text(
                        username.toString().substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 70,
                      child: InkWell(
                          onTap: () {
                            openCameraOverlay();
                          },
                          child: Image.asset('assets/camera.png')),
                    ),
                  ]),
                ),
                Text(
                  '$lastname $firstname',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffffffff),
                  ),
                ),
                Text(
                  'User Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffffffff),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
