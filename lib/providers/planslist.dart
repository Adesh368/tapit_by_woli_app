import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapit_by_wolid_app/model/data_model.dart';

class TapitProvider with ChangeNotifier {
  List<DataModel> dataplansmtn = [];
  List<DataModel> dataplansglo = [];
  List<DataModel> dataplansairtel = [];
  List<DataModel> dataplans9mobile = [];
  /*
  String setpin1 = '';
  String setpin2 = '';
  String setpin3 = '';
  String setpin4 = '';
  */
// getdataplan
  Future getRequest() async {
    final url = Uri.parse('https://api.tapit.ng/api/smeplans?type=data');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      final responsedata = jsonDecode(response.body);
     // print(responsedata);

      if (response.statusCode == 200 && responsedata['data'] != null) {
        final datamtn = responsedata['data']['data']['1'];
        final dataglo = responsedata['data']['data']['4'];
        final data9mobile = responsedata['data']['data']['3'];
        final dataairtel = responsedata['data']['data']['2'];
        if (datamtn != null) {
          for (var ids in datamtn) {
            dataplansmtn.add(DataModel(
                id: ids['id'],
                name: ids['name'],
                price: ids['price'],
                telcoprice: ids['telco_price']));
          }
        }
        if (dataglo != null) {
          for (var ids in dataglo) {
            dataplansglo.add(DataModel(
                id: ids['id'].toString(),
                name: ids['name'],
                price: ids['price'],
                telcoprice: ids['telco_price']));
          }
        }
        if (data9mobile != null) {
          for (var ids in data9mobile) {
            dataplans9mobile.add(DataModel(
                id: ids['id'].toString(),
                name: ids['name'],
                price: ids['price'],
                telcoprice: ids['telco_price']));
          }
        }
        if (dataairtel != null) {
          for (var ids in dataairtel) {
            dataplansairtel.add(DataModel(
                id: ids['id'].toString(),
                name: ids['name'],
                price: ids['price'],
                telcoprice: ids['telco_price']));
          }
        }
      }

      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  List<DataModel>? get listofdataplansmtn {
    return dataplansmtn;
  }

  List<DataModel>? get listofdataplansglo {
    return dataplansglo;
  }

  List<DataModel>? get listofdataplansairtel {
    return dataplansairtel;
  }

  List<DataModel>? get listofdataplans9mobile {
    return dataplans9mobile;
  }
}
