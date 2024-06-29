import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_endpoints.dart';

import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email' : emailController.text.trim(),
        'password' : passwordController.text
      };

      http.Response response = await http.post(url, body: jsonEncode(body),headers : headers);
      if(response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['access_token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          emailController.clear();
          passwordController.clear();
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      }

    }
      catch (error){
      Get.back();
      showDialog(context: Get.context!, builder: (context) {
    return SimpleDialog(
    title: Text('Error'),
    contentPadding: EdgeInsets.all(20),
    children: [Text(error.toString())],
    );
    });



    }
  }

}