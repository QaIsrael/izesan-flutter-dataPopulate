import 'dart:async';
import '../utils/local_store.dart';

class ErrorState {
  ///Create StreamController
  final StreamController<ErrorStatus> _controller =
      StreamController<ErrorStatus>.broadcast();

  updateError() {
    ///Add Error Enum to _controller
    _controller.add(ErrorStatus.ERROR);
  }

  ///Access the controllers stream through the stream property
  Stream<ErrorStatus> get streamError => _controller.stream;
}

// class NoInternetException {
//   String message;
//   NoInternetException(this.message);
// }
//
// class NoServiceFoundException {
//   String message;
//   NoServiceFoundException(this.message);
// }
//
// class InvalidFormatException {
//   String message;
//   InvalidFormatException(this.message);
// }
//
// class UnknownException {
//   String message;
//   UnknownException(this.message);
// }
