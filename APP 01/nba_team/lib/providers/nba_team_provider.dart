import 'package:flutter/material.dart';

class NBATeamProvider extends ChangeNotifier {
  late String teamName;
  late String teamId;

  Future<void> changeTeamName(String NewteamName) async {
    teamName = NewteamName;
  }

  Future<void> changeTeamId(String NewteamId) async {
    teamId = NewteamId;
  }

  String get selectedTeamName => teamName;

  String get selectedTeamId => teamId;
}
