import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/data/topit_items.dart';
import 'package:tapit_by_wolid_app/providers/refresh_indicator.dart';
import 'package:tapit_by_wolid_app/screens/buy_airtime_screen.dart';
import 'package:tapit_by_wolid_app/screens/buydata_screen.dart';
import 'package:tapit_by_wolid_app/screens/fund_account_screen.dart';
import 'package:tapit_by_wolid_app/screens/transfer_screen.dart';
import 'package:tapit_by_wolid_app/widgets/advert_widget.dart';
import 'package:tapit_by_wolid_app/widgets/categories_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int current = 0;
  PageController? _pagecontroller;
  bool obscuretext = false;
  String? balance;
  String? username;
  String? token;
  String? update;
  String? image;

  @override
  void initState() {
    _pagecontroller = PageController(initialPage: 0);
    getSavedData();
    super.initState();
  }

  Future<void> getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    //var extracteduserimage = json.decode(prefs.getString('profileImage').toString());
    setState(() {
      balance = extracteduserdata['balance'];
      username = extracteduserdata['username'];
      token = extracteduserdata['token'];
      image = extracteduserdata['image'];
      /*
      if (extracteduserimage != null) {
        _selectedImage = File(extracteduserimage['image']);
      }
      */
    });
  }

  // Refresh Indicator Method
  Future _refreshData() async {
    final authmodel =
        await Provider.of<GetUserDetailsProvider>(context, listen: false)
            .getUserDetails(tokenn: token.toString());
    final responsedata = jsonDecode(authmodel.body);
    if (responsedata != null && balance != responsedata['balanace']) {
      setState(() {
        balance = responsedata['balance'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    //final authmodel = Provider.of<SettingsProvider>(context, listen: true).uploadedImage;
    //_selectedImage = authmodel;
    return Scaffold(
      body: Container(
        width: screenwidth,
        height: screenheight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/aboutt.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: screenwidth,
              height: screenheight - 65,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              //{automod.username}
                              'Hi $username',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: const Color(0xffffffff))),
                          Container(
                            width: 30,
                            height: 30,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffffffff),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: image != null
                                  ? Image.network(
                                      'https://api.tapit.ng/public/storage/images/$image',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : Text(
                                      username
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: const Color(0xffffffff),
                                              fontSize: 20)),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 28, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 31, 33, 128),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                      'Your Tap Balance',
                                      style: GoogleFonts.mulish(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffE6E9FF),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
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
                                  ]),
                                  obscuretext
                                      ? Text(
                                          '₦$balance',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xffffffff)),
                                        )
                                      : Text(
                                          '*' * balance.toString().length,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xffffffff)),
                                        ),
                                ]),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const FundAccountScreen();
                                }));
                              },
                              child: Container(
                                //width: 100,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fund',
                                        style: GoogleFonts.mulish(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1E33F4),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset('assets/direct.png'),
                                    ]),
                              ),
                            ),
                          ]),
                    ),
                    // const SizedBox(height: 100,),
                  ]),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 40,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color(0xffffffff),
                  ),
                  height: screenheight * 0.56,
                  width: double.infinity,
                  child: Column(children: [
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
                                  return BuyAirtimeScreen(
                                    balance: balance.toString(),
                                  );
                                }));
                              },
                              child: const CategoriesWidget(
                                  title: 'Buy Airtime',
                                  color: Colors.orange,
                                  image: 'assets/airtime.png')),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return BuyDataScreen(
                                  balance: balance.toString(),
                                );
                              }));
                            },
                            child: const CategoriesWidget(
                                title: 'Buy Data',
                                color: Colors.green,
                                image: 'assets/data.png'),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
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
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
