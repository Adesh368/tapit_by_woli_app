import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapit_by_wolid_app/model/cart_model.dart';
import 'package:tapit_by_wolid_app/model/usermodel.dart';

class TapitProvider with ChangeNotifier {
  List<Airtime> airtimepurchased = [];
  String usernumber = '';
  String setpin1 = '';
  String setpin2 = '';
  String setpin3 = '';
  String setpin4 = '';
  Usermodel? userinfo;
  DateTime? currentdate;
  String? userfirstname;
  Future userinput(
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
      usernumber = phonenumberd;
       if (response.statusCode == 200) {
        userinfo = Usermodel(
            firstname: responsedata['data']['fname'],
            lastname: responsedata['data']['lname'],
            email: responsedata['data']['email'],
            username: responsedata['data']['username'],
            phonenumber: responsedata['data']['phone'],
            token: responsedata['token'],
            amount: responsedata['data']['balance'],
            bankname: responsedata['data']['bankname'],
            accountnumber: responsedata['data']['bank']);
            
            userfirstname = responsedata['data']['fname'];
      }
      
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  
  Future userlogins(String userloginname, String userpassword) async {
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
      print(responsedata['token']);

     if (response.statusCode == 200) {
        userinfo = Usermodel(
            firstname: responsedata['data']['fname'],
            lastname: responsedata['data']['lname'],
            email: responsedata['data']['email'],
            username: responsedata['data']['username'],
            phonenumber: responsedata['data']['phone'],
            token: responsedata['token'],
            amount: responsedata['data']['balance'],
            bankname: responsedata['data']['bankname'],
            accountnumber: responsedata['data']['bank']);
            
            userfirstname = responsedata['data']['fname'];
      }
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //buyairtimefunction
  Future additems(String image,String network,String amount) async {
    airtimepurchased.add(Airtime(image: image, network: network, amount: amount),);
     notifyListeners();
  }

  Usermodel? get listofname {
    return userinfo;
  }

  List<Airtime>? get listofairtime {
    return airtimepurchased;
  }
  //codesentfunction
}
