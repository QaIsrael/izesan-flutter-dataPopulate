
import 'package:deep_pick/deep_pick.dart';
import 'package:izesan/locator.dart';
import 'package:izesan/services/home_page_services.dart';
import 'package:dio/dio.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';

import '../model/user_details.dart';
import '../utils/local_store.dart';
import 'base_model.dart';

class HomePageModel extends BaseViewModel {
  final HomePageServices _homePageServices = locator<HomePageServices>();
  UserData? meDetails;
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();


  Future<dynamic> getCustomerFacilities(limit) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _homePageServices.download(limit);
      setStatus(ViewStatus.Success);
      return response?.data['data'];
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'get_facilities',
            identity: value?.phone,
            meta: {},
            isError: true,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch(e) {
      setStatus(ViewStatus.Error);
      rethrow;
    }
  }

  Future<dynamic> getMeDetails() async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _homePageServices.getMeDetails();
      // setStatus(ViewStatus.Success);
      // final Map<String, dynamic> data =
      // pick(response.data, 'data').asMapOrEmpty();
      // UserData meDetails = UserData.fromJson(data);
      // await LocalStoreHelper.saveMeDetails(meDetails);
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      if (e.response != null) {
        errorMessage = e.response!.data['message'];
        // return setError(e, 'Oops Something Went Wrong, Try Again');
        rethrow;
      }
      // setError(e, 'Oops Something Went Wrong, Try Again');
      rethrow;
    } catch (e) {
      setStatus(ViewStatus.Error);
      rethrow;
    }
  }


}
