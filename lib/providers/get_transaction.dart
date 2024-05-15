import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tapit_by_wolid_app/model/gettransaction.dart';

class GetTransactionProvider with ChangeNotifier {
  List<GetTransaction> getTransaction = [];

  // Get Transaction Request
  Future getTransactionRequest({required String tokenn}) async {
    final url = Uri.parse('https://api.tapit.ng/api/gettransaction');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn'
        },
      );
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      if (response.statusCode == 200 && responsedata != null) {
        final datamtn = responsedata['data'];
        if (datamtn != null) {
          for (var ids in datamtn) {
            getTransaction.add(
              GetTransaction(
                  date: ids['updated_at'],
                  amount: ids['amount'],
                  type: ids['type'],
                  network: ids['network'],
                  status: ids['status'],
                  s: ids['s']),
            );
          }
        }
      }

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

   List<GetTransaction>? get listoftransaction {
    return getTransaction;
  }
}
