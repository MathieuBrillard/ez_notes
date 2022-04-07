import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'username';
  static const _keyPassword = 'password';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUsername, value: username);
  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUsername);
  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future deleteUsername() async =>
      await _storage.delete(key: _keyUsername);
  static Future deletePassword() async =>
      await _storage.delete(key: _keyPassword);
}
