import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LivingRoomLightsService {
  final String baseUrl;

  LivingRoomLightsService({required this.baseUrl});

  Future<void> setLivingRoomLightsStatus(bool state) async {
    try {
      final url = Uri.parse('$baseUrl/led/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'state': state}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to Control Lights: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to send request: $e');
    }
  }
}
