import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapit_by_wolid_app/model/gettransaction.dart';
import 'package:tapit_by_wolid_app/providers/get_transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<GetTransaction> transactionCart = [];
  bool isComplete = true;
  String? token;
  String gloImage ='assets/gloo.png';
  String mtnImage = 'assets/mtnn.png';
  String airtelImage = 'assets/airtell.png';
  String etisalattImage = 'assets/etisalatt.png';
  String? transacttImage = 'assets/transactt.png';
  @override
  void initState() {
      getSavedBalance();
     // encodeAndDecodeString();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getList();
  }

  // Saved Token Method
  Future<void> getSavedBalance() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata = json.decode(prefs.getString('useremail')!);
    setState(() {
      token = extracteduserdata['token'];
    });
    getTransaction();
  }

  // Get Transaction Record
  Future getTransaction() async {
    final autmodel =
        await Provider.of<GetTransactionProvider>(context, listen: false)
            .getTransactionRequest(tokenn: token.toString());
  }

  /*
  Future<void> encodeAndDecodeString() async {
    var userDatas = json.encode({
      'mtnimage': 'assets/mtnn.png',
      'gloimage': 'assets/gloo.png',
      'airtelimage': 'assets/airtell.png',
      'etisalatimage': 'assets/etisalatt.png',
      'transactimage': 'assets/transactt.png'
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('image', userDatas);

    var extracteduserdata = json.decode(prefs.getString('image')!);
    if (extracteduserdata != null) {
      setState(() {
        mtnImage = extracteduserdata['mtnimage'];
        gloImage = extracteduserdata['gloimage'];
        airtelImage = extracteduserdata['airtelimage'];
        etisalattImage = extracteduserdata['etisalatimage'];
        transacttImage = extracteduserdata['transactimage'];
      });
    }
  }
  */

  Future getList() async {
    final authmodel = Provider.of<GetTransactionProvider>(context, listen: true)
        .listoftransaction;
    setState(() {
      transactionCart = authmodel!;
    });
  }

  // OnSearch Method
  onSearch(String searchText) {
    List<GetTransaction> filteredTransactionCart = [];
    if (searchText.isEmpty) {
      filteredTransactionCart = transactionCart;
      getTransaction();
    } else {
      filteredTransactionCart = transactionCart
          .where((transaction) =>
              transaction.s.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      transactionCart = filteredTransactionCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
          child: Column(children: [
            Text(
              'Transactions',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isComplete = true;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 47),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff1E33F4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Text(
                    'Completed',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xffffffff),
                        ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isComplete = false;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 47),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF2F3FF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Text(
                    'Scheduled',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffF2F3FF),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(Icons.search_sharp),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      onSearch(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Transaction',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
              ]),
            ),

            //airtimepurchase
            if (isComplete)
              Expanded(
                child: ListView.builder(
                    itemCount: transactionCart.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Image.asset(transactionCart[index].network ==
                                          '1'
                                      ? mtnImage.toString()
                                      : transactionCart[index].network == '2'
                                          ? airtelImage.toString()
                                          : transactionCart[index].network ==
                                                  '3'
                                              ? etisalattImage.toString()
                                              : transactionCart[index]
                                                          .network ==
                                                      '4'
                                                  ? gloImage.toString()
                                                  : transacttImage.toString()),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text(
                                          transactionCart[index].network == '1'
                                              ? 'MTN'
                                              : transactionCart[index]
                                                          .network ==
                                                      '2'
                                                  ? 'Airtel'
                                                  : transactionCart[index]
                                                              .network ==
                                                          '3'
                                                      ? '9Mobile'
                                                      : transactionCart[index]
                                                                  .network ==
                                                              '4'
                                                          ? 'Glo'
                                                          : 'Card Payment',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                        ),
                                        Text(
                                            transactionCart[index].status == '1'
                                                ? '(succes)'
                                                : '(fail)'),
                                      ]),
                                      Text(transactionCart[index].type == '1'
                                          ? 'Airtime purchase'
                                          : transactionCart[index].type == '2'
                                              ? 'Data subscription'
                                              : 'Account Funding'),
                                    ],
                                  ),
                                ]),
                              ),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₦${transactionCart[index].amount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          transactionCart[index]
                                              .date
                                              .substring(11, 16),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          transactionCart[index]
                                              .date
                                              .substring(0, 10),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                        )
                                      ],
                                    )
                                  ])
                            ]),
                      );
                    }),
              ),
          ]),
        ),
      ),
    );
  }
}
