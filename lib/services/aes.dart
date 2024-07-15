import 'package:encrypt/encrypt.dart' as encrypt;

class AESEncryptDecrypt {
  static Map<String, String> encryptAES(plainText) {
    final key = encrypt.Key.fromLength(16);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encryptedText = encrypter.encrypt(plainText, iv: iv);

    return {
      'encryptedText': encryptedText.base64,
      'key': key.base64,
      'IV': iv.base64,
    };
  }

  static String decryptAES(
    String encryptedTextBase64,
    String ivBase64,
    String keyBase64,
  ) {
    final key = encrypt.Key.fromBase64(keyBase64);
    final iv = encrypt.IV.fromBase64(ivBase64);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encryptedText = encrypt.Encrypted.fromBase64(encryptedTextBase64);
    final decryptText = encrypter.decrypt(encryptedText, iv: iv);
    return decryptText;
  }
}
