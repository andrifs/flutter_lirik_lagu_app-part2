import 'dart:convert';

import 'package:flutter_lirik_lagu_app/data/models/lagu_response_model.dart';
import 'package:http/http.dart' as http;

class LaguRemoteDatasource {
  final String baseUrl = 'http://192.168.0.105:8000';

  // Get  data
  Future<LaguResponseModel> getLaguDaerah() async {
    final response = await http.get(Uri.parse('$baseUrl/api/lagudaerah'));
    if (response.statusCode == 200) {
      return LaguResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //  Get data page
  Future<LaguResponseModel> getLaguDaerahPages(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/lagudaerah?page=$page'));
    if (response.statusCode == 200) {
      return LaguResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Add
  Future<void> addLaguDaerah(String judul, String lagu, String daerah) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/lagudaerah'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'judul': judul,
        'lagu': lagu,
        'daerah': daerah,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add data');
    }
  }

  // Update
  Future<void> updateLaguDaerah(
      int id, String judul, String lagu, String daerah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/lagudaerah/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'judul': judul,
        'lagu': lagu,
        'daerah': daerah,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  // Delete
  Future<void> deleteLaguDaerah(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/api/lagudaerah/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }
}
