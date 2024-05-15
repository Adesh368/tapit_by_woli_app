import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapit_by_wolid_app/model/userdetails_model.dart';
import 'dart:convert';

class AirtimeProvider with ChangeNotifier {
 
  UserDetails? airtimeInvoice;
 

 

  // Select Airtime Network Confirmation Method
  Future selectedNetwork({
    required String network,
    required String amount,
    required String phone,
    required String commission,
  }) async {
    airtimeInvoice = UserDetails(
        network: network, amount: amount, phone: phone, commission: commission);
    notifyListeners();
  }

  // Airtime Invoice Getter
  UserDetails? get userDetails {
    return airtimeInvoice;
  }

 

  // Buy Airtime Request
  Future airtimeRequest({
    required String token,
    required String phone,
    required String amount,
    required String onSelectNetwork,
  }) async {
    final url = Uri.parse('https://api.tapit.ng/api/transaction');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            'reciever': phone,
            'type': 1,
            'status': 1,
            'ref': 'ref',
            'amount': amount,
            'plan': 'plan',
            'name': 'name',
            'network': onSelectNetwork,
            'planid': 'planid',
            'am': amount,
            'mtn': 'mtn',
            'm': 'app'
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
