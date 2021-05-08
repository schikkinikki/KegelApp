import 'package:flutter/widgets.dart';
import 'dart:convert';

class Kegelbruder extends ChangeNotifier {
  String name;
  bool isKing;
  bool isPumpenKing;
  int isSelected = 0;
  int pumpe = 0;
  int klingeln = 0;
  int stina = 0;
  int durchwurf = 0;
  int handy = 0;
  int kugelBringen = 0;
  int zweiPersonenAufDerBahn = 0;
  int lustwurf = 0;

  Kegelbruder.c2();

  Kegelbruder(
      {@required this.name,
      this.isKing,
      this.isPumpenKing,
      this.pumpe = 0,
      this.klingeln = 0,
      this.stina = 0,
      this.durchwurf = 0,
      this.handy = 0,
      this.kugelBringen = 0,
      this.lustwurf = 0,
      this.zweiPersonenAufDerBahn = 0,
      this.isSelected = 0});

  Kegelbruder get spieler {
    return spieler;
  }

  Kegelbruder clientFromJson(String str) {
    final jsonData = json.decode(str);
    return Kegelbruder.fromMap(jsonData);
  }

  String clientToJson(Kegelbruder data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  //fromMap for database
  factory Kegelbruder.fromMap(Map<String, dynamic> json) {
    return new Kegelbruder(
        name: json["name"],
        pumpe: json["pumpe"],
        klingeln: json["klingeln"],
        stina: json["stina"],
        durchwurf: json["durchwurf"],
        handy: json["handy"],
        kugelBringen: json["kugelbringen"],
        lustwurf: json["lustwurf"],
        zweiPersonenAufDerBahn: json["zweiPersonenAufDerBahn"],
        isSelected: json["isSelected"]);
  }

  //Map for database
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pumpe": pumpe,
      "klingeln": klingeln,
      "stina": stina,
      "durchwurf": durchwurf,
      "handy": handy,
      "kugelbringen": kugelBringen,
      "lustwurf": lustwurf,
      "zweiPersonenAufDerBahn": zweiPersonenAufDerBahn,
      "isSelected": isSelected
    };
  }

  //change selection, needed for DropDownButton Widget
  void setSelected() {
    if (isSelected == 0) {
      isSelected = 1;
    }
    notifyListeners();
  }

//getters and setters
  int get pumpen {
    return pumpe;
  }

  int get klingel {
    return klingeln;
  }

  int get mittenDurch {
    return stina;
  }

  int get durchWurf {
    return durchwurf;
  }

  int get telefon {
    return handy;
  }

  int get kugelbringen {
    return kugelBringen;
  }

  int get zuZweitaufDerBahn {
    return zweiPersonenAufDerBahn;
  }

  int get lustWurf {
    return lustwurf;
  }

  void setPumpe(int strafe) {
    this.pumpe += strafe;
    notifyListeners();
  }

  void setKlingeln(int klingeln) {
    this.klingeln += klingeln;
    notifyListeners();
  }

  void setMittenDurch(int mittenDurch) {
    this.stina += mittenDurch;
    notifyListeners();
  }

  void setDurchWurf(int durchWurf) {
    this.durchwurf += durchwurf;
    notifyListeners();
  }

  void setHandy(int handy) {
    this.handy += handy;
    notifyListeners();
  }

  void setKugelBringen(int kugelBringen) {
    this.kugelBringen += kugelBringen;
    notifyListeners();
  }

  void setLustwurf(int lustWurf) {
    this.lustwurf += lustWurf;
    notifyListeners();
  }

  void setZuZweitaufDerBahn(int zuZweitaufDerBahn) {
    this.zweiPersonenAufDerBahn += zuZweitaufDerBahn;
    notifyListeners();
  }
}
