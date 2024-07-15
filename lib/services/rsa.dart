import 'package:http/http.dart' as http;
import 'dart:convert';

class RSAEncryptDecrypt {
  static const String baseUrl = 'https://flask-rsa-api.onrender.com';

  static Future<Map<String, dynamic>> encryptMessage(String message) async {
    final url = Uri.parse("$baseUrl/encrypt");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      print("responce: ${response.body}");
      return json.decode(response.body);
    } else {
      throw Exception('Failed to encrypt message');
    }
  }

  static Future<Map<String, dynamic>> decryptMessage(
      String encryptedMessage, String key) async {
    final url = Uri.parse('$baseUrl/decrypt');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'encrypted_message': encryptedMessage, 'key': key}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to decrypt message');
    }
  }
}
