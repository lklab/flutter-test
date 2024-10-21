import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final _streamController = StreamController<UserCredential?>();
  UserCredential? _currentUser;

  void setUser(UserCredential? user) {
    _currentUser = user;
    _streamController.sink.add(_currentUser);
  }

  UserCredential? getCurrentUser() {
    return _currentUser;
  }

  Stream<UserCredential?> getStream() {
    return _streamController.stream;
  }
}
