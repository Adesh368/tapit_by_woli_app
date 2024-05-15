import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SettingsProvider with ChangeNotifier {
  File? selectedImage;

  Future takePicture(
    ImageSource source,
    String token,
    String fname,
    String lname,
  ) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: source, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    selectedImage = File(pickedImage.path);

    final url = Uri.parse('https://api.tapit.ng/api/updateuser');
    try {
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll(<String, String>{
        'Authorization': 'Bearer $token',
      });

      // Add form fields
      request.fields['fname'] = fname;
      request.fields['lname'] = lname;

      // Add image file
      var imageField =
          await http.MultipartFile.fromPath('image', selectedImage!.path);
      request.files.add(imageField);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final responsedata = jsonDecode(response.body);
      //print(responsedata);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /*
  Future takePicture(ImageSource source,String token,String fname,String lname) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    selectedImage = File(pickedImage.path);

    final url = Uri.parse('https://api.tapit.ng/api/updateuser');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          { 'fname': fname,
            'lname': lname, 
            'image': selectedImage!.path,
          },
        ),
      );
      final responsedata = jsonDecode(response.body);
      print(responsedata);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
  */
}
