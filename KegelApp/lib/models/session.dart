import 'dart:convert';

import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';

class Session {
  String date;
  Kegelbruder kegelbruder;
  int isSelected = 0;

  Session({this.date, this.kegelbruder, this.isSelected = 0});

  //Map for database
  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "name": kegelbruder.name,
      "pumpe": kegelbruder.pumpe,
      "klingeln": kegelbruder.klingeln,
      "stina": kegelbruder.stina,
      "durchwurf": kegelbruder.durchwurf,
      "handy": kegelbruder.handy,
      "kugelbringen": kegelbruder.kugelBringen,
      "lustwurf": kegelbruder.lustwurf,
      "zweiPersonenAufDerBahn": kegelbruder.zweiPersonenAufDerBahn,
      "kugelKlo": kegelbruder.kugelKlo,
      "kugelFallenLassen": kegelbruder.kugelFallenLassen,
      "alleNeune": kegelbruder.alleNeune,
      "isKing": kegelbruder.isKing,
      "isPumpenKing": kegelbruder.isPumpenKing,
      "isSelected": isSelected
    };
  }

  //fromMap for database
  factory Session.fromMap(Map<String, dynamic> json) {
    return new Session(
      date: json["date"],
      isSelected: json["isSelected"],
      kegelbruder: new Kegelbruder(
          name: json["name"],
          pumpe: json["pumpe"],
          klingeln: json["klingeln"],
          stina: json["stina"],
          durchwurf: json["durchwurf"],
          handy: json["handy"],
          kugelBringen: json["kugelbringen"],
          lustwurf: json["lustwurf"],
          zweiPersonenAufDerBahn: json["zweiPersonenAufDerBahn"],
          kugelKlo: json["kugelKlo"],
          kugelFallenLassen: json["kugelFallenLassen"],
          alleNeune: json["alleNeune"],
          isKing: json["isKing"],
          isPumpenKing: json["isPumpenKing"]),
    );
  }

  String clientToJson(Session data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  Session clienFromJson(String str) {
    final jsonData = jsonDecode(str);
    return Session.fromMap(jsonData);
  }

  void setSelected(int selection) {
    this.isSelected += selection;
  }
}

class SessionProvider extends ChangeNotifier {
  List<Session> sessionList = [];

  Future<List<Session>> getSessions() async {
    sessionList = await DBProvider.db.getAllSessions();
    return sessionList;
  }
}
