import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/product.dart';

class ProductController {
  static Future products_controller_api() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.escuelajs.co/api/v1/products'));
      final data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return Products.fromJson(data);
      } else {
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
