import 'package:flutter/material.dart';

class NBAUserProvider extends ChangeNotifier {
  late String userName;
  late String userId;

  Future<void> changeUserName(String NewUserName) async {
    userName = NewUserName;
  }

  Future<void> changeUserId(String NewUserId) async {
    userId = NewUserId;
  }

  String get selectedUserName => userName;

  String get selectedUserId => userId;
}
