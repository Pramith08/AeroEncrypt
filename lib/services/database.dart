import 'dart:convert';
import 'package:aeroencrypt/services/aes.dart';
import 'package:aeroencrypt/services/rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> addData(
    String uId, String appName, String username, String password) async {
  final appCollectionKey = 'user_$uId/$appName';

  final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  final existingIdentifiers =
      await storage.read(key: '$appCollectionKey/identifiers') ?? '[]';

  final List<String> identifiers =
      List<String>.from(json.decode(existingIdentifiers));

  // Encrypt UserName using AES
  Map<String, String> encryptionResultUsername =
      AESEncryptDecrypt.encryptAES(username);

  final encryptedUsername = encryptionResultUsername['encryptedText'];
  final tempEncryptedUsernameKey = encryptionResultUsername['key'];
  final encryptedUsernameIV = encryptionResultUsername['IV'];

  // Encrypt Username key using rsa
  Map<String, dynamic> rsaUsernameResult =
      await RSAEncryptDecrypt.encryptMessage(tempEncryptedUsernameKey!);

  final rsaEncryptedAESUsernameKey = rsaUsernameResult['encrypted_message'];
  final _rsaUsernameKey = rsaUsernameResult['key'];

  //Encrypt Password using AES
  Map<String, String> encryptionResultPassword =
      AESEncryptDecrypt.encryptAES(password);

  final encryptedPassword = encryptionResultPassword['encryptedText'];
  final tempEncryptedPasswordKey = encryptionResultPassword['key'];
  final encryptedPasswordIV = encryptionResultPassword['IV'];

  // Encrypt Username key using rsa
  Map<String, dynamic> rsaPasswordResult =
      await RSAEncryptDecrypt.encryptMessage(tempEncryptedPasswordKey!);

  final rsaEncryptedAESPasswordKey = rsaPasswordResult['encrypted_message'];
  final _rsaPassowrdKey = rsaPasswordResult['key'];

  //Store username
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username', value: encryptedUsername);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username/key',
      value: rsaEncryptedAESUsernameKey);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username/rsakey',
      value: _rsaUsernameKey);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username/IV',
      value: encryptedUsernameIV);

  //Store password
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password', value: encryptedPassword);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password/key',
      value: rsaEncryptedAESPasswordKey);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password/rsakey',
      value: _rsaPassowrdKey);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password/IV',
      value: encryptedPasswordIV);

  identifiers.add(uniqueId);

  await storage.write(
      key: '$appCollectionKey/identifiers', value: json.encode(identifiers));

  await addAppName(uId, appName);
}

Future<List<Map<String, String?>>> getData(String uId, String appName) async {
  final appCollectionKey = 'user_$uId/$appName';

  final allAppData = <Map<String, String?>>[];

  final existingIdentifiers =
      await storage.read(key: '$appCollectionKey/identifiers') ?? '[]';

  final List<String> identifiers =
      List<String>.from(json.decode(existingIdentifiers));

  for (final id in identifiers) {
    //get Username Encrypted Details
    final encryptedUsername =
        await storage.read(key: '$appCollectionKey/$id/username');
    final rsaEncryptedAESUsernameKey =
        await storage.read(key: '$appCollectionKey/$id/username/key');
    final rsaUsernameKey =
        await storage.read(key: '$appCollectionKey/$id/username/rsakey');
    final encryptedUsernameIV =
        await storage.read(key: '$appCollectionKey/$id/username/IV');

    //decrypt username key using rsa
    Map<String, dynamic> rsaUsernameResult =
        await RSAEncryptDecrypt.decryptMessage(
            rsaEncryptedAESUsernameKey!, rsaUsernameKey!);

    String aesUsernameKey = rsaUsernameResult['decrypted_message'];

    //decrypt Username using AES
    final decryptedUsername = AESEncryptDecrypt.decryptAES(
        encryptedUsername.toString(),
        encryptedUsernameIV.toString(),
        aesUsernameKey.toString());

    //get Password Encrypted Details
    final encryptedPassword =
        await storage.read(key: '$appCollectionKey/$id/password');
    final rsaEncryptedAESPasswordKey =
        await storage.read(key: '$appCollectionKey/$id/password/key');
    final rsaPasswordKey =
        await storage.read(key: '$appCollectionKey/$id/password/rsakey');
    final encryptedPasswordIV =
        await storage.read(key: '$appCollectionKey/$id/password/IV');

    //decrypt password key using rsa
    Map<String, dynamic> rsaPasswordResult =
        await RSAEncryptDecrypt.decryptMessage(
            rsaEncryptedAESPasswordKey!, rsaPasswordKey!);

    String aesPasswordKey = rsaPasswordResult['decrypted_message'];

    //decrypt Password using AES
    final decryptedPassword = AESEncryptDecrypt.decryptAES(
        encryptedPassword.toString(),
        encryptedPasswordIV.toString(),
        aesPasswordKey.toString());

    allAppData.add({
      'username': decryptedUsername,
      'password': decryptedPassword,
      'uniqueId': id
    });
  }

  return allAppData;
}

Future<List<String>> getAppNames(String uId) async {
  final appNamesKey = 'user_$uId/appNames';
  final existingAppNames = await storage.read(key: appNamesKey) ?? '[]';

  return List<String>.from(json.decode(existingAppNames));
}

Future<void> addAppName(String uId, String appName) async {
  final appNamesKey = 'user_$uId/appNames';
  final existingAppNames = await getAppNames(uId);

  if (!existingAppNames.contains(appName)) {
    existingAppNames.add(appName);
    await storage.write(key: appNamesKey, value: json.encode(existingAppNames));
  }
}

Future<void> deleteCredential(
    String uniqueId, String uId, String appName) async {
  final appCollectionKey = 'user_$uId/$appName';

  // Remove identifier from the list
  final existingIdentifiers =
      await storage.read(key: '$appCollectionKey/identifiers') ?? '[]';
  List<String> identifiers =
      List<String>.from(json.decode(existingIdentifiers));
  identifiers.remove(uniqueId);
  await storage.write(
      key: '$appCollectionKey/identifiers', value: json.encode(identifiers));

  // Remove the username and password
  await storage.delete(key: '$appCollectionKey/$uniqueId/username');
  await storage.delete(key: '$appCollectionKey/$uniqueId/password');

  if (identifiers.isEmpty) {
    await removeAppName(uId, appName);
  }
}

Future<void> removeAppName(String uId, String appName) async {
  final appNamesKey = 'user_$uId/appNames';
  List<String> existingAppNames = await getAppNames(uId);

  if (existingAppNames.contains(appName)) {
    existingAppNames.remove(appName);
    await storage.write(key: appNamesKey, value: json.encode(existingAppNames));
  }
}
