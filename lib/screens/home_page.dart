import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/data/topit_items.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/buy_airtime_screen.dart';
import 'package:tapit_by_wolid_app/screens/fund_account_screen.dart';
import 'package:tapit_by_wolid_app/screens/transfer_screen.dart';
import 'package:tapit_by_wolid_app/widgets/advert_widget.dart';
import 'package:tapit_by_wolid_app/widgets/categories_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int current = 0;
  PageController? _pagecontroller;
  bool obscuretext = false;
  @override
  void initState() {
    _pagecontroller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final automod =
        Provider.of<TapitProvider>(context, listen: false).listofname!;
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: const AssetImage('assets/homepage.png'),
          height: screenheight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 60,
          left: 20,
          right: 20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Hi ${automod.username}',
              style: GoogleFonts.mulish(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xffffffff),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                //color: const Color(0xffF2F3FF),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffffffff),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                  child: Text(
                automod.username.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffffffff),
                ),
              )),
            ),
          ]),
        ),
        //YourBalance
        Positioned(
          left: 20,
          right: 20,
          top: 100,
          child: Container(
            width: double.infinity,
            height: screenheight - 695,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 31, 33, 128),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenwidth - 255,
                    height: screenheight - 750,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Tap Balance',
                              style: GoogleFonts.mulish(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffE6E9FF),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  obscuretext = !obscuretext;
                                });
                              },
                              child: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        obscuretext? Text(
                          '₦${automod.amount}',
                          style: GoogleFonts.mulish(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xffFFFFFF),
                          ),
                        ): Text('*'* automod.amount.length,style: GoogleFonts.mulish(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xffFFFFFF),
                          )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const FundAccountScreen();
                      }));
                    },
                    child: Container(
                      width: screenwidth - 310,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fund',
                            style: GoogleFonts.mulish(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff1E33F4),
                            ),
                          ),
                          Image.asset('assets/direct.png'),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        Positioned(
          top: 250,
          left: 0,
          right: 0,
          child: Container(
            width: screenwidth,
            height: screenheight - 166,
            decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(children: [
              /*
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: screenheight - 736,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    border:
                        Border.all(width: 1, color: const Color(0xffE6E9FF)),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenwidth - 175,
                          height: screenheight - 778,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Verify your Identity',
                                  style: GoogleFonts.mulish(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff1F1F1F),
                                  ),
                                ),
                                Text(
                                  'for us to provide you with your personalized bank account for Wallet funding',
                                  softWrap: true,
                                  style: GoogleFonts.mulish(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff666666),
                                  ),
                                )
                              ]),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff1E33F4),
                        ),
                      ]),
                ),
              ),
              */
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 70,
                ),
                child: SizedBox(
                  height: screenheight - 590,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const TransferScreen();
                                  }));
                                },
                                child: const CategoriesWidget(
                                    title: 'Transfer',
                                    color: Colors.purple,
                                    image: 'assets/transfer.png')),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const BuyAirtimeScreen();
                                  }));
                                },
                                child: const CategoriesWidget(
                                    title: 'Buy Airtime',
                                    color: Colors.orange,
                                    image: 'assets/airtime.png')),
                            const CategoriesWidget(
                                title: 'Buy Data',
                                color: Colors.green,
                                image: 'assets/data.png'),
                          ],
                        ),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoriesWidget(
                                  title: 'Cable & TV',
                                  color: Colors.pink,
                                  image: 'assets/tv.png'),
                              CategoriesWidget(
                                  title: 'Bill Payment',
                                  color: Colors.lightBlue,
                                  image: 'assets/bill.png'),
                              CategoriesWidget(
                                  title: 'Refer & Earn',
                                  color: Color.fromARGB(255, 203, 84, 224),
                                  image: 'assets/earn.png')
                            ]),
                      ]),
                ),
              ),
              SizedBox(
                height: screenheight - 740,
                width: double.infinity,
                child: PageView.builder(
                    onPageChanged: (int index) {
                      setState(() {
                        current = index;
                      });
                    },
                    controller: _pagecontroller,
                    itemCount: adverts.length,
                    itemBuilder: (ctx, index) {
                      return AdvertWidget(image: adverts[index].add1);
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    adverts.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: (index == current) ? 20 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: (index == current)
                            ? const Color(0xff1E33F4)
                            : const Color(0xff666666),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
