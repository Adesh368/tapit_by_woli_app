import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/data/network_data.dart';
import 'package:tapit_by_wolid_app/providers/planslist.dart';
import 'package:tapit_by_wolid_app/screens/data_confirmation_payment.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/network_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class BuyDataScreen extends StatefulWidget {
  const BuyDataScreen({required this.balance,super.key});

  final String balance;

  @override
  State<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends State<BuyDataScreen> {
  final _numbercontroller = TextEditingController();
  final _numbertextinputtype = TextInputType.number;
  String? choosenetwork;
  String? networkimage;
  bool rechargeschedule = false;
  final formatter = DateFormat.yMd();
  String isempty = '';
  bool mtnplans = false;
  String? changenetworkplan;
  String? changenetworkamount;
  int? selectedIndex;
  String? plan;
  String? choosenplan;
  String? amount;
  String? planid;
  bool isLoding = true;
 

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  // Get Plans LIst Method
  Future getRequest() async {
    setState(() {
      isLoding = true;
    });
    final autmodel =
        await Provider.of<TapitProvider>(context, listen: false).getRequest();
    setState(() {
      isLoding = false;
    });
    
  }

  // Validation Method
  Future _validate() async {
    if (choosenetwork == null) {
      setState(() {
        isempty = 'Please select a network';
      });
    } else if (_numbercontroller.text.isEmpty) {
      setState(() {
        isempty = 'Invalid Phone number';
      });
    } else if (selectedIndex == null) {
      setState(() {
        isempty = 'Please select a plan';
      });
    } else if (double.parse(widget.balance.toString()) <
        double.parse(amount.toString())) {
      setState(() {
        isempty = 'Insufficient balance';
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return DataConfirmPaymentScreen(
            amount: amount.toString(),
            planid: plan!,
            network: choosenetwork.toString(),
            phone: _numbercontroller.text,
            plan: planid!);
      }));
    }
  }

  // Selected Plan Method
  onSelectPlan(int indexx) async {
    if (choosenetwork == 'MTN') {
      final autmodel = Provider.of<TapitProvider>(context, listen: false)
          .listofdataplansmtn!;
      changenetworkplan = autmodel[indexx].name;
      changenetworkamount = autmodel[indexx].price.toString();
      choosenplan = autmodel[indexx].id;
    } else if (choosenetwork == 'Glo') {
      final autmodel = Provider.of<TapitProvider>(context, listen: false)
          .listofdataplansglo!;
      changenetworkplan = autmodel[indexx].name;
      changenetworkamount = autmodel[indexx].price.toString();
      choosenplan = autmodel[indexx].id;
    } else if (choosenetwork == '9mobile') {
      final autmodel = Provider.of<TapitProvider>(context, listen: false)
          .listofdataplans9mobile!;
      changenetworkplan = autmodel[indexx].name;
      changenetworkamount = autmodel[indexx].price.toString();
      choosenplan = autmodel[indexx].id;
    } else if (choosenetwork == 'Airtel') {
      final autmodel = Provider.of<TapitProvider>(context, listen: false)
          .listofdataplansairtel!;
      changenetworkplan = autmodel[indexx].name;
      changenetworkamount = autmodel[indexx].price.toString();
      choosenplan = autmodel[indexx].id;
    } else {
      return;
    }
  }

  //showdialog
  void onSelectNetwork() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: SizedBox(
              height: 210,
              width: 400,
              child: Column(
                children: [
                  const Text(
                    'Choose Network',
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: selectnetwork.length,
                        itemBuilder: (ctxx, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                choosenetwork = selectnetwork[index].network;
                                networkimage = selectnetwork[index].image;
                                mtnplans = true;
                              });
                              Navigator.of(context).pop();
                            },
                            child: NetworkWidget(
                                image: selectnetwork[index].image,
                                text: selectnetwork[index].network),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final autmodelmtn =
        Provider.of<TapitProvider>(context, listen: false).listofdataplansmtn!;
    final autmodelglo =
        Provider.of<TapitProvider>(context, listen: false).listofdataplansglo!;
    final autmodel9mobile = Provider.of<TapitProvider>(context, listen: false)
        .listofdataplans9mobile!;
    final autmodelairtel = Provider.of<TapitProvider>(context, listen: false)
        .listofdataplansairtel!;
    return Scaffold(
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 11, bottom: 20),
                child: Column(children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.arrow_back)),
                                  Text(
                                    'Buy Data',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                  const SizedBox(),
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                isempty,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffEC1A23),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Wallet Balance: ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                  Text(
                                    '₦${widget.balance}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mulish(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff1F1F1F),
                                    ),
                                  ),
                                ]),
                            Text('Network',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.mulish(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff1A1A1A),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                onSelectNetwork();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffE6E9FF)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        choosenetwork == null
                                            ? 'Choose network'
                                            : choosenetwork!,
                                        style: GoogleFonts.mulish(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff1A1A1A),
                                        )),
                                    Image.asset('assets/arrowbutton.png'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                maxword: [
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textobsure: false,
                                controller: _numbercontroller,
                                title: 'Phone Number',
                                labeled: '081********',
                                textInputType: _numbertextinputtype),
                            const SizedBox(
                              height: 20,
                            ),
                            if (mtnplans) const Text('Data Plans'),
                            if (mtnplans)
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: choosenetwork == 'MTN'
                                        ? autmodelmtn.length
                                        : choosenetwork == 'Glo'
                                            ? autmodelglo.length
                                            : choosenetwork == 'Airtel'
                                                ? autmodelairtel.length
                                                : choosenetwork == '9mobile'
                                                    ? autmodel9mobile.length
                                                    : 0,
                                    itemBuilder: (ctx, index) {
                                      onSelectPlan(index);
                                      List<Color> colors = [
                                        const Color.fromARGB(255, 233, 233, 87),
                                        const Color.fromARGB(255, 30, 235, 136),
                                        const Color.fromARGB(255, 50, 181, 241),
                                        const Color.fromARGB(
                                            255, 238, 103, 103),
                                        const Color.fromARGB(255, 235, 56, 181),
                                      ];
                                      Color selectedColor =
                                          colors[index % colors.length];
                                      // Selected Plan Method
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                          if (choosenetwork == 'MTN') {
                                            setState(() {
                                              amount = autmodelmtn[index]
                                                  .price
                                                  .toString();
                                              plan = autmodelmtn[index]
                                                  .name
                                                  .toString();
                                              planid = autmodelmtn[index]
                                                  .id
                                                  .toString();
                                            });
                                          } else if (choosenetwork == 'Glo') {
                                            setState(() {
                                              amount = autmodelglo[index]
                                                  .price
                                                  .toString();
                                              plan = autmodelglo[index]
                                                  .name
                                                  .toString();
                                              planid = autmodelglo[index]
                                                  .id
                                                  .toString();
                                            });
                                          } else if (choosenetwork ==
                                              'Airtel') {
                                            setState(() {
                                              amount = autmodelairtel[index]
                                                  .price
                                                  .toString();
                                              plan = autmodelairtel[index]
                                                  .name
                                                  .toString();
                                              planid = autmodelairtel[index]
                                                  .id
                                                  .toString();
                                            });
                                          } else if (choosenetwork ==
                                              '9mobile') {
                                            setState(() {
                                              amount = autmodel9mobile[index]
                                                  .price
                                                  .toString();
                                              plan = autmodel9mobile[index]
                                                  .name
                                                  .toString();
                                              planid = autmodel9mobile[index]
                                                  .id
                                                  .toString();
                                            });
                                          } else {
                                            return;
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          width: 131,
                                          decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? selectedColor.withOpacity(0.7)
                                                : selectedColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                changenetworkplan.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: GoogleFonts.mulish(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff1A1A1A),
                                                ),
                                              ),
                                              Text('₦$changenetworkamount'),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                          ]),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        _validate();
                      },
                      child: const NavigateWidget(navigationvalue: 'continue'))
                ]),
              ),
            ),
    );
  }
}
