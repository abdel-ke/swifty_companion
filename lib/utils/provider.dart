import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/models/authentication.dart';

class MyProvider extends ChangeNotifier {
  late User _user;
  final Authentication _auth = Authentication();
  final TextEditingController _controller = TextEditingController();
  late User _futureUser;
  late Coalition _futureCoalition;
  String _promo = '42';

  User get user => _user;
  get auth => _auth;
  TextEditingController get controller => _controller;
  String get promo => _promo;

  void setPromo(String promo) {
    _promo = promo;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setFutureUser(User user) {
    _futureUser = user;
    notifyListeners();
  }

  void setFutureCoalition(Coalition coalition) {
    _futureCoalition = coalition;
    notifyListeners();
  }

  User get futureUser => _futureUser;

  Coalition get futureCoalition => _futureCoalition;
}