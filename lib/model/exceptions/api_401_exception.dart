class Api401Exception implements Exception {

  late String message = "UnAuthorized";
  late int code;
  var realReason;

  Api401Exception({String? message, int? code, String? realReason}){
    this.message = message!;
    this.code = code!;
    realReason = realReason;
  }
}
