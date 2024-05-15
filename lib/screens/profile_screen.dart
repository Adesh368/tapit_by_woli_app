import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/widgets/profile_widget.dart';
import 'package:tapit_by_wolid_app/widgets/subsettings_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  Future<void> getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      email = extracteduserdata['email'];
      username = extracteduserdata['username'];
      firstname = extracteduserdata['firstname'];
      lastname = extracteduserdata['lastname'];
      phone = extracteduserdata['phone'];
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
        height: screenheight * 0.7,
        width: double.infinity,
        child:  Column(
         
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileWidget(data: username.toString(), title: 'Username'),
            ProfileWidget(data: firstname.toString(), title: 'First Name'),
            ProfileWidget(data: lastname.toString(), title: 'Last Name'),
            ProfileWidget(data: email.toString(), title: 'Email'),
            ProfileWidget(data: '234$phone', title: 'Phone Number'),
          ],
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
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xffFFFFFF),
                          )),
                      Text(
                        'My Profile',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffffffff),
                        ),
                      ),
                      const Icon(
                        Icons.edit,
                        color: Color(0xffFFFFFF),
                      ),
                    ]),
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffffffff),
                  ),
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
              ]),
        ),
      ),
    );
  }
}
