import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';

Future<void> downloadFile(SendPort sendPort) async {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  await for (var msg in receivePort) {
    String url = msg[0];
    String filename = msg[1];
    SendPort replyPort = msg[2];

    try {
      final dio = Dio();
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      await dio.download(url, file.path);
      replyPort.send(file.path);
    } catch (e) {
      replyPort.send(null);
    }
  }
}