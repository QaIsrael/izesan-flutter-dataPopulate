import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

///The IsolateHandler class is designed to handle the task of downloading and
///saving a video file in a separate isolate. Using an isolate ensures that
///the main UI thread remains responsive, as the heavy task of downloading and
///saving the video is offloaded to a background thread.

class IsolateHandler {
  static Future<void> downloadAndSaveVideo(Map<String, dynamic> args) async {
    final String url = args['url'];
    final String fileName = args['fileName'];
    final SendPort sendPort = args['sendPort'];
    // Path passed from main isolate
    final String directoryPath = args['directoryPath'];

    final Dio dio = Dio();
    final filePath = '$directoryPath/$fileName';

    try {
      await dio.download(url, filePath);
      sendPort.send(filePath);
    } catch (e) {
      sendPort.send('error');
    }
  }
}
