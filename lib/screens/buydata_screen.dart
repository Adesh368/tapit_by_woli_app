import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/data/network_data.dart';
import 'package:tapit_by_wolid_app/provider.dart';
import 'package:tapit_by_wolid_app/screens/airtime_confirm_payment_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/network_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class BuyDataScreen extends StatefulWidget {
  const BuyDataScreen({super.key});

  @override
  State<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends State<BuyDataScreen> {
  final _numbercontroller = TextEditingController();
  final _numbertextinputtype = TextInputType.number;
  final _amountcontroller = TextEditingController();
  final _amounttextinputtype = TextInputType.number;
  String? choosenetwork;
  String? networkimage;
  bool rechargeschedule = false;
  DateTime? selectedDate;
  DateTime? selectedEndDate;
  String? dropdownvalue = 'Every Day';
  final formatter = DateFormat.yMd();
  String isempty = '';

  
  //additemstocart
  Future addtocart() async {
    if (choosenetwork == null) {
      setState(() {
        isempty = 'Please select a network';
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const AirtimeConfirmPaymentScreen();
      }));
      setState(() {
       Provider.of<TapitProvider>(context,listen: false).currentdate = DateTime.now();
      });
      final authmodel = await Provider.of<TapitProvider>(context, listen: false)
          .additems(networkimage!, choosenetwork!, _amountcontroller.text);
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

  //selectstartdate
  void showdate() async {
    final currentdate = DateTime.now();
    final firstdate = DateTime(
      currentdate.year - 1,
      currentdate.month,
      currentdate.day,
    );
    final datepicker = await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: firstdate,
      lastDate: currentdate,
    );

    setState(() {
      selectedDate = datepicker;
    });
  }

  //selectenddate
  void showenddate() async {
    final currentdate = DateTime.now();
    final firstdate = DateTime(
      currentdate.year - 1,
      currentdate.month,
      currentdate.day,
    );
    final datepicker = await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: firstdate,
      lastDate: currentdate,
    );

    setState(() {
      selectedEndDate = datepicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final automod =
        Provider.of<TapitProvider>(context, listen: false).listofname!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back)),
                Text(
                  'Buy Data',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
                const SizedBox(),
              ]),
              const SizedBox(
                height: 30,
              ),
              Text(
                isempty,
                style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffEC1A23),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Wallet Balance: ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
                Text(
                  '₦${automod.amount}',
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
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffE6E9FF)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    InkWell(
                        onTap: () {
                          onSelectNetwork();
                        },
                        child: Image.asset('assets/arrowbutton.png')),
                  ],
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
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: InkWell(
                    onTap: () {
                      addtocart();
                    },
                    child: const NavigateWidget(navigationvalue: 'continue')),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
