import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class WindowService {
  final String baseUrl;

  WindowService({required this.baseUrl});

  Future<void> setWindowStatus(String status) async {
    try {
      final url = Uri.parse('$baseUrl/control/window');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': status}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to control window: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      // You can also rethrow the exception if you want
      // rethrow;
    }
  
  }
  }


