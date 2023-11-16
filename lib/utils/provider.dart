import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/models/authentication.dart';

class MyProvider extends ChangeNotifier {
  late User _user;
  final Authentication _auth = Authentication();

  User get user => _user;
  get auth => _auth;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

}