// TODO: CHANGE APPROACH TO USE FLAVORS AS THIS CURRENTLY REQUIRES MANUALLY MODIFYING
// static const environment = ENV.DEV; line

enum ENV {
  DEV,
  PROD,
  STAGING,
  TEST,
}

class EnvConfig {

  // static const LOCAL_URL = 'http://live.izesan.com';
  static const LOCAL_URL = 'http://3.16.87.74/api/v1';
  static const NGROK = 'https://af17-197-210-70-223.ng/mobile';
  // static const PROD_URL = 'https://app.izesan.ng';

  static const environment = ENV.DEV;
  static final baseUrl = getBaseUrl(environment);
  static const timeout = Duration(seconds: 60); //35000;
  static const receiveTimeout = Duration(seconds: 60); //35000;

  static getBaseUrl(env) {
    switch (env) {
      case ENV.DEV:
        return LOCAL_URL;
      // return NGROK;
      case ENV.PROD:
        return LOCAL_URL;
      // return NGROK;
      default:
        return LOCAL_URL;
    }
  }
}