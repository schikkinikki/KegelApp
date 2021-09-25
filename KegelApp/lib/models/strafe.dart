import 'dart:convert';

import 'package:KegelApp/database/kegelAppDatabase.dart';

class Strafe {
  double strafenHoehe;
  String strafenName;
  int index;

  Strafe({this.strafenName, this.strafenHoehe, this.index});

  //Setters
  void setStrafenName(String name) {
    this.strafenName = name;
  }

  void setStrafenHoehe(double strafenSatz) {
    this.strafenHoehe = strafenSatz;
  }

  void setIndex(int index) {
    this.index = index;
  }

  //database functions
  Strafe clientFromJson(String str) {
    final jsonData = jsonDecode(str);
    return Strafe.fromMap(jsonData);
  }

  String clientToJson(Strafe data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  factory Strafe.fromMap(Map<String, dynamic> json) {
    return Strafe(
        strafenName: json["strafenName"],
        strafenHoehe: json["strafenHoehe"],
        index: json["strafenIndex"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "strafenName": strafenName,
      "strafenHoehe": strafenHoehe,
      "strafenIndex": index
    };
  }

  void setNewIndex(Strafe strafe) async {
    List<Strafe> strafenListe = await DBProvider.db.getAllStrafen();
    List<int> indexListe = [];
    strafenListe.forEach((strafe) {
      indexListe.add(strafe.index);
    });
    int highestIndex = indexListe[0];
    indexListe.forEach((element) {
      if (element > highestIndex) {
        highestIndex = element;
      }
    });
    int newIndex = highestIndex + 1;
    strafe.setIndex(newIndex);
  }
}
