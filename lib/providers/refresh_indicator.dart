import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUserDetailsProvider with ChangeNotifier {
  // Get UserDetails Request
  Future getUserDetails({required String tokenn}) async {
    final url = Uri.parse('https://api.tapit.ng/api/getdatils');
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
      print(responsedata);

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
