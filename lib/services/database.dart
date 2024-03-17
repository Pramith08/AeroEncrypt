import 'dart:convert';
import 'package:aeroencrypt/services/encrypt_decrypt.dart';
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

  Map<String, String> encryptionResultUsername =
      AESEncryptDecrypt.encryptAES(username);

  final encryptedUsername = encryptionResultUsername['encryptedText'];
  final encryptedUsernameKey = encryptionResultUsername['key'];
  final encryptedUsernameIV = encryptionResultUsername['IV'];

  Map<String, String> encryptionResultPassword =
      AESEncryptDecrypt.encryptAES(password);

  final encryptedPassword = encryptionResultPassword['encryptedText'];
  final encryptedPasswordKey = encryptionResultPassword['key'];
  final encryptedPasswordIV = encryptionResultPassword['IV'];

  // Encrypt UserName
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username', value: encryptedUsername);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username/key',
      value: encryptedUsernameKey);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/username/IV',
      value: encryptedUsernameIV);

  //Encrypt Password
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password', value: encryptedPassword);
  await storage.write(
      key: '$appCollectionKey/$uniqueId/password/key',
      value: encryptedPasswordKey);
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
    final encryptedUsernameKey =
        await storage.read(key: '$appCollectionKey/$id/username/key');
    final encryptedUsernameIV =
        await storage.read(key: '$appCollectionKey/$id/username/IV');

    //decrypt Username
    final decryptedUsername = AESEncryptDecrypt.decryptAES(
        encryptedUsername.toString(),
        encryptedUsernameIV.toString(),
        encryptedUsernameKey.toString());

    //get Password Encrypted Details
    final encryptedPassword =
        await storage.read(key: '$appCollectionKey/$id/password');
    final encryptedPasswordKey =
        await storage.read(key: '$appCollectionKey/$id/password/key');
    final encryptedPasswordIV =
        await storage.read(key: '$appCollectionKey/$id/password/IV');

    //decrypt Password
    final decryptedPassword = AESEncryptDecrypt.decryptAES(
        encryptedPassword.toString(),
        encryptedPasswordIV.toString(),
        encryptedPasswordKey.toString());

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
