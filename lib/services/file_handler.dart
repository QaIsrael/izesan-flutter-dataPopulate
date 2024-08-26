import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../utils/encryption_helper.dart';

class FileHandler {
  final Dio dio = Dio();

  Future<String> _downloadAndSaveImageWithEncryption(String url, String filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      final tempFile = File('${directory.path}/temp_$filename');

      // Download the file
      final response = await dio.download(url, tempFile.path);
      if (kDebugMode) {
        print('response for image download: ${tempFile.path}');
      }

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        // Read the downloaded file
        final data = tempFile.readAsBytesSync();

        // Encrypt the data
        final encryptedData = await EncryptionHelper.encryptData(Uint8List.fromList(data));

        // Write encrypted data to the final file
        file.writeAsBytesSync(encryptedData);

        // Delete the temporary file
        tempFile.deleteSync();

        return file.path;
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      throw Exception('Error downloading and saving image: $e');
    }
  }

  Future<Uint8List> loadAndDecryptImage(String filePath) async {
    final file = File(filePath);
    final encryptedData = file.readAsBytesSync();
    return await EncryptionHelper.decryptData(encryptedData);
  }

  Future<dynamic> downloadAndSaveVideo(String url, String filename) async {
    try{
      Response? response;
      final dio = Dio();
      Directory? dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/$filename'); //How can i hide or encrypt this Path.
      response = await dio.download(url, file.path);
        print('response for image down ${file.path}');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return file.path;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> downloadAndSaveAudio(String url, String filename) async {
    try{
      Response? response;
      final dio = Dio();
      Directory? dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/$filename');
      response = await dio.download(url, file.path);
        print('response for audio download ${file.path}');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return file.path;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> downloadSaveLanguageImages(String url, String filename) async {
    try{
      Response? response;
      final dio = Dio();
      Directory? dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/$filename');
      response = await dio.download(url, file.path);
        print('response language :-- for image down ${file.path}');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return file.path;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> downloadSaveLessonsImages(String url, String filename) async {
    try{
      Response? response;
      final dio = Dio();
      Directory? dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/$filename');
      response = await dio.download(url, file.path);
      print('response lessons:-- for image down ${file.path}');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return file.path;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<dynamic> downloadSaveGameImage(String url, String filename, {int retries = 3, int delay = 2000}) async {
    int attempt = 0;

    while (attempt < retries) {
      try {
        attempt++;
        final dio = Dio();
        Directory? dir = await getApplicationSupportDirectory();
        final file = File('${dir.path}/$filename');
        final response = await dio.download(url, file.path);

        print('response lessons:-- for image down ${file.path}');
        if (response.statusCode! >= 200 && response.statusCode! <= 300) {
          return file.path;
        }
      } catch (e) {
        if (attempt >= retries) {
          rethrow;
        } else {
          print('Download failed, retrying in ${delay / 1000} seconds... (Attempt $attempt of $retries)');
          await Future.delayed(Duration(milliseconds: delay));
        }
      }
    }
  }



  Future<Uint8List> loadAndDecryptVideo(String filePath) async {
    final file = File(filePath);
    final encryptedData = await file.readAsBytes();
    return await _decryptData(encryptedData);
  }

  /// Encryption: Encrypt the video files before saving them to the device storage.
  /// Secure Storage: Save the encrypted files in a secure directory.
  /// Decryption on Access: Decrypt the files when accessed through the app.

  static Future<Uint8List> _decryptData(Uint8List data) async {

    // final key = await EncryptionHelper.getEncryptionKey().toString();
    // if (key == null) {
    //   throw Exception('Encryption key not found');
    // }
    // final keyBytes = base64Url.decode(key);

    ///IV(Uint8List(16)); is creating an Initialization Vector (IV)
    /// for use with a block cipher encryption algorithm (like AES).
    final initializationVector = IV(Uint8List(16)); // Same IV used during encryption

    final encrypter = encrypt.Encrypter(
        encrypt.AES(await EncryptionHelper.getEncryptionKey()));

    final decrypted = encrypter.decryptBytes(Encrypted(data), iv: initializationVector);
    return Uint8List.fromList(decrypted);
  }

}