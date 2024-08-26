import 'dart:async';

import '../utils/local_store.dart';

class AuthState {
  final StreamController<AuthStatus> _controller = StreamController<AuthStatus>.broadcast();

  logOut() {
    _controller.add(AuthStatus.LOGGED_OUT);
  }

  Stream get stream => _controller.stream;
}