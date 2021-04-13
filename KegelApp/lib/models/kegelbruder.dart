import 'package:flutter/widgets.dart';
import 'dart:convert';

class Kegelbruder extends ChangeNotifier {
  String name;
  bool isKing;
  bool isPumpenKing;
  bool isSelected = false;
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
      this.pumpe,
      this.klingeln,
      this.stina,
      this.durchwurf,
      this.handy,
      this.kugelBringen,
      this.lustwurf,
      this.zweiPersonenAufDerBahn});

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
        zweiPersonenAufDerBahn: json["zweiPersonenAufDerBahn"]);
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
    };
  }

  //needed for strafen-Ui
  List<int> strafenListe = [0, 0, 0, 0, 0, 0, 0, 0];

  List<int> get strafenListen {
    return strafenListe;
  }

  int getSingleStrafe(int index) {
    return strafenListe[index];
  }

  //change selection, needed for DropDownButton Widget
  void setSelected() {
    if (!isSelected) {
      isSelected = true;
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
    this.pumpe = strafe;
    notifyListeners();
  }

  void setKlingeln(int klingeln) {
    this.klingeln = klingeln;
    notifyListeners();
  }

  void setMittenDurch(int mittenDurch) {
    this.stina = mittenDurch;
    notifyListeners();
  }

  void setDurchWurf(int durchWurf) {
    this.durchwurf = durchwurf;
    notifyListeners();
  }

  void setHandy(int handy) {
    this.handy = handy;
    notifyListeners();
  }

  void setKugelBringen(int kugelBringen) {
    this.kugelBringen = kugelBringen;
    notifyListeners();
  }

  void setLustwurf(int lustWurf) {
    this.lustwurf = lustWurf;
    notifyListeners();
  }

  void setZuZweitaufDerBahn(int zuZweitaufDerBahn) {
    this.zweiPersonenAufDerBahn = zuZweitaufDerBahn;
    notifyListeners();
  }
}
