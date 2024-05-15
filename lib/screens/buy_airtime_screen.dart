import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tapit_by_wolid_app/data/network_data.dart';
import 'package:tapit_by_wolid_app/providers/airtime.dart';
import 'package:tapit_by_wolid_app/screens/airtime_confirm_payment_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/network_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

class BuyAirtimeScreen extends StatefulWidget {
  const BuyAirtimeScreen({required this.balance,super.key});

  final String balance;

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
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
 
  // Dropdown Items
  var items = [
    'Every Day',
    'Every 7 Days',
    'Every 30 Days',
  ];

  // Validate Method
  Future _validate() async {
    if (choosenetwork == null) {
      setState(() {
        isempty = 'Please select a network';
      });
    } else if (_numbercontroller.text.isEmpty) {
      setState(() {
        isempty = 'inValid Phone Number';
      });
    } else if (_amountcontroller.text.isEmpty) {
      setState(() {
        isempty = 'inValid Phone Number';
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const AirtimeConfirmPaymentScreen();
      }));
      final authmodelconfirm =
          // ignore: use_build_context_synchronously
          await Provider.of<AirtimeProvider>(context, listen: false)
              .selectedNetwork(
                  network: choosenetwork!,
                  amount: _amountcontroller.text,
                  phone: _numbercontroller.text,
                  commission: '₦2.000');
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 20),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.arrow_back)),
                            Text(
                              'Buy Airtime',
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
                              style: GoogleFonts.mulish(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff1A1A1A),
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
                      TextFieldWidget(
                          textobsure: false,
                          controller: _amountcontroller,
                          title: 'Amount',
                          labeled: '0.00',
                          textInputType: _amounttextinputtype),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Schedule recharge',
                                style: GoogleFonts.mulish(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff1A1A1A),
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    rechargeschedule = !rechargeschedule;
                                  });
                                },
                                child: rechargeschedule
                                    ? const Icon(Icons.expand_less)
                                    : const Icon(Icons.expand_more)),
                          ]),
                      const SizedBox(height: 10),
                      //date
                      if (rechargeschedule)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Start Date',
                                        style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1A1A),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      height: 50,
                                      width: 148,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE6E9FF),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                selectedDate == null
                                                    ? 'Date'
                                                    : formatter
                                                        .format(selectedDate!),
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      const Color(0xff1A1A1A),
                                                )),
                                            Container(
                                              width: 41,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff1E33F4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: InkWell(
                                                onTap: () {
                                                  showdate();
                                                },
                                                child: const Icon(
                                                  Icons.calendar_month,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('End Date',
                                        style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1A1A),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      height: 50,
                                      width: 148,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE6E9FF),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                selectedEndDate == null
                                                    ? 'Date'
                                                    : formatter.format(
                                                        selectedEndDate!),
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xff1F1F1F),
                                                )),
                                            Container(
                                              width: 41,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff1E33F4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: InkWell(
                                                onTap: () {
                                                  showenddate();
                                                },
                                                child: const Icon(
                                                  Icons.calendar_month,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    )
                                  ]),
                            ]),
                      const SizedBox(
                        height: 20,
                      ),
                      if (rechargeschedule)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Time',
                                        style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1A1A),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      height: 50,
                                      width: 148,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE6E9FF),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Time',
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xff1F1F1F),
                                                )),
                                            Container(
                                              width: 30,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff1E33F4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Icon(
                                                Icons.time_to_leave_outlined,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ]),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Occurence',
                                        style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1A1A),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      height: 50,
                                      width: 148,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE6E9FF),
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xff1E33F4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          value: dropdownvalue!.isNotEmpty
                                              ? dropdownvalue
                                              : null,
                                          items: items.map((String item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(item,
                                                  style: GoogleFonts.mulish(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xff1F1F1F),
                                                  )),
                                            );
                                          }).toList(),
                                          onChanged: (String? newvalue) {
                                            setState(() {
                                              dropdownvalue = newvalue!;
                                            });
                                          }),
                                    )
                                  ]),
                            ]),
                    ]),
              ),
            ),
            InkWell(
                onTap: () {
                  _validate();
                },
                child: const NavigateWidget(navigationvalue: 'continue')),
          ]),
        ),
      ),
    );
  }
}
