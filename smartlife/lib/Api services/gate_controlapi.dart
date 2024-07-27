import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GateService {
  final String baseUrl;

  GateService({required this.baseUrl});

  Future<void> setGateStatus(String status) async {
    try {
      final url = Uri.parse('$baseUrl/control/gate');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': status}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to control gate: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      // You can also rethrow the exception if you want
      // rethrow;
    }
  
  }
  }


