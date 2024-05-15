import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tapit_by_wolid_app/model/usermodel.dart';

class SignInProvider with ChangeNotifier {
  Usermodel? userInfo;

  // Sign In Request Method
  Future userSignIn(String userloginname, String userpassword) async {
    final url = Uri.parse('https://api.tapit.ng/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'id': userloginname,
            'password': userpassword,
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      if (response.statusCode == 200) {
        userInfo = Usermodel(
            firstname: responsedata['data']['fname'],
            lastname: responsedata['data']['lname'],
            email: responsedata['data']['email'],
            username: responsedata['data']['username'],
            phonenumber: responsedata['data']['phone'],
            token: responsedata['token'],
            amount: responsedata['data']['balance'],
            bankname: responsedata['data']['bankname'],
            accountnumber: responsedata['data']['bank'],
            image: responsedata['data']['image']);
      }
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

    // user getter
   Usermodel? get listofname {
    return userInfo;
  }
}
