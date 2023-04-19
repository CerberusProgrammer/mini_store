import 'dart:convert';
/*
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  String username;
  late String? _password;
  bool needPassword = false;
  final storage = const FlutterSecureStorage();

  User({
    this.username = 'Default',
    String? password,
    bool setPassword = true,
  }) {
    if (setPassword && password != null) {
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      _password = digest.toString();
      storage.write(key: 'password', value: _password);
    }
  }

  Future<bool> authenticate(String password) async {
    if (_password == null) {
      return false;
    }
    var storedPassword = await storage.read(key: 'password');
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return storedPassword == digest.toString();
  }
}
*/