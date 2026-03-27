import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _fullName = '';
  String _email = '';

  String get fullName => _fullName;
  String get email => _email;

  void setUserData(String fullName, String email) {
    _fullName = fullName;
    _email = email;
    notifyListeners();
  }

  void clearUserData() {
    _fullName = '';
    _email = '';
    notifyListeners();
  }
}
