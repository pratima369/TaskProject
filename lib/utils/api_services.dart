import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/product.dart';

class ApiServices{


  // With Model
  Future<Products?> getProducts()async{
    try{

      var response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
      if(response.statusCode == 200){
        Products model = Products.fromJson(json.decode(response.body));
        return model;
      }
    }catch (e){
      print(e.toString());
    }
    return null;
  }





  // WithOut Model
  Future<dynamic> getSinglePostWithoutModel()async{
    try{

      var response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return data;
      }
    }catch (e){
      print(e.toString());
    }
    return null;
  }



  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/users'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> createData() async {
    final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': 'Flutter HTTP CRUD',
          'body': 'This is a blog post about HTTP CRUD methods in Flutter',
          'userId': 1,
        }));

    if (response.statusCode != 201) {
      throw Exception('Failed to create data');
    }
  }



  Future<void> deleteData(int id) async {
    final response = await http.delete(Uri.parse('https://api.escuelajs.co/api/v1/users/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

}
Future<void> updateData(int id) async {
  final response = await http.put(Uri.parse('https://api.escuelajs.co/api/v1/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'Flutter HTTP CRUD',
        'body': 'This is an updated blog post about HTTP CRUD methods in Flutter',
        'userId': 1,
      }));

  if (response.statusCode != 200) {
    throw Exception('Failed to update data');
  }
}
