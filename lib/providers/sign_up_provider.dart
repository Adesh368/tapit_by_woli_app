import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tapit_by_wolid_app/model/usermodel.dart';

class SignUpProvider with ChangeNotifier {
  Usermodel? userInfo;

  // Sign Up Request Method
   Future userSignUp(
      {required String firstnamed,
      required String emaild,
      required String usernamed,
      required String phonenumberd,
      required String passwordd}) async {
    final url = Uri.parse('https://api.tapit.ng/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            'fname': firstnamed,
            'lname': 'lastname',
            'email': emaild,
            'username': usernamed,
            'phone': phonenumberd,
            'password': passwordd,
            'm': 'app',
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userInfo = Usermodel(
            firstname: responsedata['data']['fname'],
            lastname: responsedata['data']['lname'],
            email: responsedata['data']['email'],
            username: responsedata['data']['username'],
            phonenumber: responsedata['data']['phone'],
            token: responsedata['token'],
            amount: responsedata['data']['balance'],
            image: responsedata['data']['image'],
            bankname: responsedata['data']['bankname']??'',
            accountnumber: responsedata['data']['bank']??'');
      }

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // User Getter
   Usermodel? get listofname {
    return userInfo;
  }
}
