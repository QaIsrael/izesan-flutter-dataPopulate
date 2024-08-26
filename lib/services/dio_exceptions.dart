import 'package:dio/dio.dart';
import '../model/exceptions/not_found_exception.dart';

class DioException implements Exception {
  late String errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.badCertificate:
        errorMessage = 'Bad certificate.';
        break;
      case DioErrorType.connectionError:
        errorMessage = 'Connection error try again';
        break;
      case DioErrorType.badResponse:
        errorMessage = _handleStatusCode(
            dioError.response?.statusCode, dioError.response?.data);
        break;
      case DioErrorType.unknown:
        if(dioError.message == null){
          errorMessage = 'Something went wrong, contact customer support.';
          break;
        }
        if (dioError.message!.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        } else if (dioError.message!.contains('HttpException')) {
          errorMessage = 'Network not Available';
          break;
        } else{
          // errorMessage = 'Unexpected error occurred.';
          break;
        }
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode, error) {
    String? errorMessage = error!['message'].isNotEmpty! ?
        NotFoundException(message: error["message"]).message
        : 'Please try again, Unexpected error occurred';
    switch (statusCode) {
      case 400:
        return errorMessage;
      case 401:
        return errorMessage;
      case 402:
        return errorMessage;
      case 403:
        return errorMessage;
      case 404:
        return errorMessage;
      case 405:
        return errorMessage;
      case 415:
        return errorMessage;
      case 422:
        return errorMessage;
      case 429:
        return errorMessage;
      case 500:
        return errorMessage;
      case 526:
        return errorMessage;
      default:
        return errorMessage;
    }
  }

  @override
  String toString() => errorMessage;
}
