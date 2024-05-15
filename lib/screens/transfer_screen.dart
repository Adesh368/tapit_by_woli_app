import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapit_by_wolid_app/screens/confirm_trans_screen.dart';
import 'package:tapit_by_wolid_app/widgets/nav_widget.dart';
import 'package:tapit_by_wolid_app/widgets/textfield_widget.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TransferScreen> {
  final _numbercontroller = TextEditingController();
  final _numbertextinputtype = TextInputType.number;
  final _amountcontroller = TextEditingController();
  final _amounttextinputtype = TextInputType.number;
  final _nameinputtype = TextInputType.text;
  final _namecontroller = TextEditingController();
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
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back)),
                      Text(
                        'Transfer',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFieldWidget(
                      maxword: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textobsure: false,
                      controller: _numbercontroller,
                      title: 'Recipient Phone Number',
                      labeled: '09021284572',
                      textInputType: _numbertextinputtype),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      textobsure: false,
                      controller: _namecontroller,
                      title: 'Receiver Name',
                      labeled: 'name',
                      textInputType: _nameinputtype),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      maxword: [FilteringTextInputFormatter.digitsOnly],
                      textobsure: false,
                      controller: _amountcontroller,
                      title: 'Amount',
                      labeled: '₦0.00',
                      textInputType: _amounttextinputtype),
                ]),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const ConfirmTransactionScreen();
                  }));
                },
                child: const NavigateWidget(navigationvalue: 'Continue'))
          ]),
        ),
      ),
    );
  }
}
