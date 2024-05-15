import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider with ChangeNotifier {
  // Buy Data Request Method
  Future requestData(
      {required String token,
      required String amount,
      required String plan,
      required String firstName,
      required String onSelectNetwork,
      required String phone}) async {
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
            'type': '2',
            'status': '1',
            'ref': 'ref',
            'amount': amount,
            'plan': plan,
            'name': firstName,
            'network': onSelectNetwork,
            'planid': plan,
            'am': amount,
            'mtn': 'x',
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
