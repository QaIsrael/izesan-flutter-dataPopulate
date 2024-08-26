import 'package:izesan/locator.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:dio/dio.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';

import '../services/notification_services.dart';
import '../utils/local_store.dart';
import 'base_model.dart';


class NotificationViewModel extends BaseViewModel {
  final NotificationServices _notificationServices = locator<NotificationServices>();

  // NotificationModel? izsNotification;
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  Future<dynamic> getNotification(int page) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _notificationServices.getNotification(page);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        // Map<String, dynamic> data = response.data['data'];
        // izsNotification = Notification.fromJson(data);
        return response.data['data'];
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = response.data['message'];
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'get_notification',
            identity: value?.phone,
            isError: true,
            errorCode: response.statusCode.toString(),
            meta: {},
            channel: 'mobile') : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch(e){
      setStatus(ViewStatus.Error);
      rethrow;
    }
    return response.data['data'];
  }


}
