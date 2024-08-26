import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionHelper {
  static const _secureStorage = FlutterSecureStorage();
  static const _keyStorageKey = 'encryption_key';

  static Future<void> initializeEncryptionKey() async {
    String? key = await _secureStorage.read(key: _keyStorageKey);
    if (key == null) {
      final newKey = encrypt.Key.fromSecureRandom(32);
      await _secureStorage.write(key: _keyStorageKey, value: newKey.base64);
    }
  }

  static Future<encrypt.Key> getEncryptionKey() async {
    final keyString = await _secureStorage.read(key: _keyStorageKey);
    if (keyString == null) {
      throw Exception('Encryption key not found');
    }
    return encrypt.Key.fromBase64(keyString);
  }

  static Future<Uint8List> encryptData(Uint8List data) async {
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(await getEncryptionKey()));
    final encrypted = encrypter.encryptBytes(data, iv: iv);
    return Uint8List.fromList(iv.bytes + encrypted.bytes);
  }

  static Future<Uint8List> decryptData(Uint8List data) async {
    final iv = encrypt.IV(data.sublist(0, 16));
    final encrypter = encrypt.Encrypter(encrypt.AES(await getEncryptionKey()));
    final encryptedData = encrypt.Encrypted(data.sublist(16));
    return Uint8List.fromList(encrypter.decryptBytes(encryptedData, iv: iv));
  }
}
