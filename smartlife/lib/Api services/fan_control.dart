
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class FanService {
  final String baseUrl;

  FanService({required this.baseUrl});

  Future<void> setFanStatus(String status) async {
    try {
      final url = Uri.parse('$baseUrl/control/fan');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': status}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to control fan: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      // You can also rethrow the exception if you want
      // rethrow;
    }
  
  }
  }


