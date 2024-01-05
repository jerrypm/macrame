import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static Future<bool> saveServerAuthCode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('auth-code', value);
  }

  static Future<bool> saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  static Future<String> getStringToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return '$token';
  }

  static Future<bool> removeStringToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove('token');
  }

  static Future<void> saveJsonToSharedPreferences(
      Map<String, dynamic> product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> productList = prefs.containsKey('json_data_key')
        ? List<Map<String, dynamic>>.from(
            jsonDecode(prefs.getString('json_data_key')!) ?? [],
          )
        : [];

    productList.add(product);

    String jsonString = jsonEncode(productList);

    prefs.setString('json_data_key', jsonString);
  }

  static Future<List<Map<String, dynamic>>>
      getJsonFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = prefs.getString('json_data_key') ?? '';

    try {
      List<Map<String, dynamic>> productList =
          List<Map<String, dynamic>>.from(jsonDecode(jsonString) ?? []);

      return productList;
    } catch (e) {
      debugPrint('Error decoding JSON: $e');
      return [];
    }
  }

  static Future<void> removeJsonByIdFromSharedPreferences(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> productList = prefs.containsKey('json_data_key')
        ? List<Map<String, dynamic>>.from(
            jsonDecode(prefs.getString('json_data_key')!) ?? [],
          )
        : [];

    productList.removeWhere((product) => product['id_item'] == id);

    String jsonString = jsonEncode(productList);

    prefs.setString('json_data_key', jsonString);
  }
}
