import 'dart:convert';

import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/screens/old_session_screen.dart';
import 'package:flutter/material.dart';

class Session {
  String date;
  Kegelbruder kegelbruder;

  Session({this.date, this.kegelbruder});

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
    };
  }

  //fromMap for database
  factory Session.fromMap(Map<String, dynamic> json) {
    return new Session(
      date: json["date"],
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
      ),
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
}

class ExpansionPanelItems {
  bool isExpanded;
  String headerValue;
  Widget expandedValue;

  ExpansionPanelItems(
      {this.isExpanded = false,
      @required this.headerValue,
      @required this.expandedValue});
}

class SessionProvider extends ChangeNotifier {
  List<Session> sessionList = [];

  Future<List<Session>> getSessions() async {
    sessionList = await DBProvider.db.getAllSessions();
    return sessionList;
  }

  List<DataRow> dataRows = [];

  void addRow() async {
    sessionList = await DBProvider.db.getAllSessions();
    sessionList.forEach((session) {
      dataRows.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(session.kegelbruder.name)),
          DataCell(Text(
            session.kegelbruder.pumpe.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.klingeln.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.stina.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.durchwurf.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.handy.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.kugelBringen.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.zweiPersonenAufDerBahn.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.lustwurf.toString(),
            textAlign: TextAlign.center,
          )),
        ]),
      );
    });
    print("Rows wurden hinzugefügt");
    notifyListeners();
  }

  var expansionPanelMap = {};

  //create sorted Map for expansion panels
  void sortAndMapLists() async {
    List<Session> unsortedSessionList = await DBProvider.db.getAllSessions();
    var sortedMap = unsortedSessionList.fold<Map<String, List<Session>>>(
        {},
        (map, session) =>
            map..update(session.date, (list) => list..add(session)));
    expansionPanelMap = sortedMap;
    notifyListeners();
  }
}
