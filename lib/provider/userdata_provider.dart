import 'package:demoprovider/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserDataProvider extends ChangeNotifier{
  Box _userBox = userDataBox;

  Box get getUserBox => _userBox;

  set setUserBox(Box value) {
    _userBox = value;
    notifyListeners();
  }
}