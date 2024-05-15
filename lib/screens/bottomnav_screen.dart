import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/screens/home_page.dart';
import 'package:tapit_by_wolid_app/screens/settings_screen.dart';
import 'package:tapit_by_wolid_app/screens/transaction_screen.dart';
import 'package:tapit_by_wolid_app/screens/verify_pin_screen.dart';

class Snavigate extends StatefulWidget {
  const Snavigate({super.key});

  @override
  State<Snavigate> createState() => _SnavigateState();
}

class _SnavigateState extends State<Snavigate> {
  int currentIndex = 0;
  bool colorchange = true;
  bool colorchanges = false;
  bool colorchanges2 = false;
  bool colorchanges3 = false;
  bool backgroundcolor = true;
  // final screens = [
  //   const DashboardScreen(),
  //   const AboutMeScreen(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            border: Border.all(width: 2, color: const Color(0xffffffff)),
            color: const Color(0xffffffff),
          ),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                    colorchange = true;
                    colorchanges = false;
                    colorchanges2 = false;
                    colorchanges3 = false;
                  });
                },
                child: colorchange
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 44,
                        width: 109,
                        decoration: BoxDecoration(
                          color: const Color(0xff1E33F4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/home_icon.png',
                                color: const Color(0xffffffff)),
                            Text('Home',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffffffff),
                                ))
                          ],
                        ),
                      )
                    : Image.asset(
                        'assets/home_icon.png',
                        color: colorchange
                            ? const Color(0xff4D7EFA)
                            : const Color(0xff3F4041),
                      ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                    colorchange = false;
                    colorchanges = true;
                    colorchanges2 = false;
                    colorchanges3 = false;
                  });
                },
                child: colorchanges
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 44,
                        width: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xff1E33F4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/arrows_icon.png',
                                color: const Color(0xffffffff)),
                            Text(
                              'Transactions',
                              softWrap: true,
                              style: GoogleFonts.mulish(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffffffff),
                              ),
                            )
                          ],
                        ),
                      )
                    : Image.asset(
                        'assets/arrows_icon.png',
                        color: colorchange
                            ? const Color(0xff666666)
                            : const Color(0xff3F4041),
                      ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                    colorchanges2 = true;
                    colorchange = false;
                    colorchanges = false;
                    colorchanges3 = false;
                  });
                },
                child: colorchanges2
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 44,
                        width: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xff1E33F4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/notificationicon.png',
                                color: const Color(0xffffffff)),
                            Text('notifications',
                                style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffffffff),
                                ))
                          ],
                        ),
                      )
                    : Image.asset(
                        'assets/notificationicon.png',
                        color: colorchange
                            ? const Color(0xff666666)
                            : const Color(0xff3F4041),
                      ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                    colorchanges3 = true;
                    colorchange = false;
                    colorchanges = false;
                    colorchanges2 = false;
                  });
                },
                child: colorchanges3
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 44,
                        width: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xff1E33F4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/settingsicon.png',
                                color: const Color(0xffffffff)),
                            Text('Account',
                                style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffffffff),
                                ))
                          ],
                        ),
                      )
                    : Image.asset(
                        'assets/settingsicon.png',
                        color: colorchange
                            ? const Color(0xff666666)
                            : const Color(0xff3F4041),
                      ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        IndexedStack(index: currentIndex, children: const [
          HomePageScreen(),
          TransactionScreen(),
          NotificationScreen(),
          SettingsScreen(),
        ]),
      ]),
    );
  }
}
