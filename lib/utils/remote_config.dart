import 'dart:async';

import 'package:izesan/utils/constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  int maxRetries = 3;
  int retryCount = 0;

  initConfig() async {
    await remoteConfig.setDefaults(defaultValue);
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 30), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds: 15), // a fetch will wait up to 10 seconds before timing out
    ));
    return await _fetchConfig();
  }

  // Fetching, caching, and activating remote config
  Future<void> _fetchConfig() async {
    try {
      await remoteConfig.fetchAndActivate();
    } catch (exception) {
      if (exception is TimeoutException && retryCount < maxRetries) {
        retryCount++;
        // Delay before retrying 3
        await Future.delayed(const Duration(seconds: 3));
        await _fetchConfig();
      } else {
        print('Failed to fetch remote config: $exception');
      }
    }
  }

}
