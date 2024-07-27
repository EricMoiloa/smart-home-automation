import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future<void> writeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }
}
